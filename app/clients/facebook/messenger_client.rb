module Facebook
  class MessengerClient

    def send_message(page_id, message)
      begin
        response = faraday_connection.post("me/messages?access_token=#{ get_page_access_token(page_id) }", message)
        response.body if response&.success?
      rescue StandardError
        nil
      end
    end

    def user_info(page_id, sender_id)
      begin
        response = faraday_connection.get("#{sender_id}?access_token=#{ get_page_access_token(page_id) }")
        response.body if response&.success?
      rescue StandardError
        nil
      end
    end

    private

    def faraday_connection
      connection = Faraday.new(url: graph_url) do |faraday|
        faraday.response :json
        faraday.request :json
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
      connection
    end

    def get_page_access_token(page_id)
      # shop = Shop.find_by(fb_page_id: page_id)
      # return shop.fb_page_access_token
      Shop.find_by(fb_page_id: page_id).fb_page_access_token
    end

    def graph_url
      ENV['FB_GRAPH_BASE_URL']
    end

  end
end