module Facebook
  class MessengerService

    def initialize(params)
      @bot_message = params[:entry].first
      page_id = @bot_message.dig(:id)
      @shop = Shop.find_by(fb_page_id: page_id)
      @token = @shop.fb_page_access_token
    end

    def process_message
      if(postback_payload == 'order')
        return send_message(email_confirm_message)
      end
      if email_message?
        return send_message(message('please visit our website'))
      end
      send_message(welcome_message)
    end

    private

    def send_message(message)
      Facebook::MessengerClient.new.send_message(@token, message)
    end

    def message(text)
      {
          recipient: {
              id: sender_id
          },
          message: {
              attachment: {
                  type: 'template',
                  payload: {
                      template_type: 'button',
                      text: text,
                      buttons: [{
                              type: 'web_url',
                              url: 'https://www.truecar.com/prices-new/porsche/718-cayman-pricing',
                              title: 'TrueCar',
                              messenger_extensions: true,
                              webview_height_ratio: 'full'
                          }]
                  }
              }
          }
      }
    end

    def welcome_message
      user = Facebook::MessengerClient.new.user_info(@token, sender_id)

      elements_array = []
      products = @shop.products
      products.each do |product|
        elements_array.push({
          title: "【#{ product.name }】 $#{ format_number(product.price) }",
          image_url: "https://rails-ec.herokuapp.com/#{ product.cover_url }",
          subtitle: product.description,
          buttons: [
            { type: 'postback', title: '訂購商品', payload: 'order' }
            # { type: 'web_url', title: '訂購商品', url: 'https://rails-ec.herokuapp.com/' }
          ]
        })
      end

      {
        recipient: {
          id: sender_id
        },
        message: {
          attachment: {
            type: 'template',
            payload: {
              template_type: 'generic',
              elements: elements_array
            }
          }
        }
      }
    end

    def email_confirm_message
      {
          recipient: { id: sender_id },
          message: { text: 'Confirm Email', quick_replies: [ { content_type: 'user_email' } ]}
      }
    end

    def sender_id
      @bot_message.dig(:messaging, 0, :sender, :id)
    end

    def postback_payload
      @bot_message.dig(:messaging, 0, :postback, :payload)
    end

    def email_message?
      @bot_message.dig(:messaging, 0, :message, :nlp, :entities, :email).present?
    end

    def format_number(number)
      whole, decimal = number.to_s.split(".")
      num_groups = whole.chars.to_a.reverse.each_slice(3)
      whole_with_commas = num_groups.map(&:join).join(',').reverse
      [whole_with_commas, decimal].compact.join(".")
    end

  end
end