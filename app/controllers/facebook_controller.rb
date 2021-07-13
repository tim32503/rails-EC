class FacebookController < ApplicationController
  skip_before_action :verify_authenticity_token

  HUB_VERIFY_TOKEN = 'hub.verify_token'.freeze
  HUB_CHALLENGE = 'hub.challenge'.freeze

  def create
    Facebook::MessengerService.new(params).process_message
    head :ok
  end

  def index
    # HUB_VERIFY_TOKEN Verify Token provided
    return head :bad_request if params[HUB_VERIFY_TOKEN] != webhook_verify_key
    render plain: params[HUB_CHALLENGE]
  end

  def test
    temp = Facebook::MessengerService.new(params)
    p temp
    # temp = params[:entry].first
    # p temp
    # p temp[:id]
    # p Shop.find_by(fb_page_id: temp[:id])
    head :ok
  end

  private

  def index_permit_params
    params.require([:HUB_VERIFY_TOKEN, :HUB_CHALLENGE]).permit(:HUB_VERIFY_TOKEN, :HUB_CHALLENGE)
  end

  def create_permit_params
    params.permit(:entry)
  end

  def webhook_verify_key
    ENV['FB_WEBHOOK_VERIFY_KEY']
  end
end