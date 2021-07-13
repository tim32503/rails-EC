module Facebook
  class MessengerClient

    def send_message(token, message)
      begin
        response = faraday_connection.post("me/messages?access_token=#{ token }", message)
        response.body if response&.success?
      rescue StandardError
        nil
      end
    end

    def user_info(token, sender_id)
      begin
        response = faraday_connection.get("#{sender_id}?access_token=#{ token }")
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

    def graph_url
      ENV['FB_GRAPH_BASE_URL']
    end

  end
end