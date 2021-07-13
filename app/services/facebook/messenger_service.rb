module Facebook
  class MessengerService

    def initialize(params)
      @bot_message = params[:entry].first
      page_id = @bot_message.dig(:id)
      @shop = Shop.find_by(fb_page_id: page_id)
      @token = @shop.fb_page_access_token
    end

    def process_message
      if postback_payload.start_with? "buy_#"
        product_id = postback_payload.slice(5..-1).to_i
        return send_message(order_message(product_id))
      end

      send_message(welcome_message)
    end

    private

    def send_message(message)
      Facebook::MessengerClient.new.send_message(@token, message)
    end

    def welcome_message
      elements_array = []
      products = @shop.products
      products.each do |product|
        elements_array.push({
          title: "【#{ product.name }】 $#{ format_number(product.price) }",
          image_url: "https://rails-ec.herokuapp.com/#{ product.cover_url }",
          subtitle: product.description,
          buttons: [
            { type: 'postback', title: '確認訂購', payload: "buy_##{ product.id }" }
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

    def order_message(product_id)
      user = Facebook::MessengerClient.new.user_info(@token, sender_id)

      order = @shop.orders.new(
        name: "#{ user[:last_name] }#{ user[:first_name] }",
        product_id: product_id
      )

      {
        recipient: { id: sender_id },
        message: { text: (order.save ? "訂購成功" : "訂購失敗") }
      }
    end

    def sender_id
      @bot_message.dig(:messaging, 0, :sender, :id)
    end

    def postback_payload
      @bot_message.dig(:messaging, 0, :postback, :payload)
    end

    def format_number(number)
      whole, decimal = number.to_s.split(".")
      num_groups = whole.chars.to_a.reverse.each_slice(3)
      whole_with_commas = num_groups.map(&:join).join(',').reverse
      [whole_with_commas, decimal].compact.join(".")
    end

  end
end