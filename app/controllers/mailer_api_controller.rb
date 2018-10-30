require 'net/http'
require 'json'

class MailerApiController < ApplicationController
  before_action :parse_request

  def check
    unless (mail = @json[:email]).present?
      render json: { response: "Parameter 'email' can't be blank" }, status: :unprocessable_entity
      return false
    else
      access_tocken = 'e98fc278c7d602330dfb0a3a32775a3c'
      url = "https://apilayer.net/api/check? access_key=#{access_tocken}& email=#{@json[:email]}"
      uri = URI(url)
      response = JSON.parse(Net::HTTP.get(uri))

      if response['smtp_check']
        render json: {response: "email exist :)"}, status: :ok
      else
        render json: {response: " #{@json[:email]} does not exist as an SMTP domain"}, status: :not_found
      end
    end
    rescue
      render json: { response: "something went wrong!!" }, status: :bad_request
  end

  private

  def parse_request
    if request.method != 'GET'
      render json: { response: "We accept GET requests only" }, status: :bad_request
    else
        @json = params
    end
  rescue
    render json: { response: "JSON not valid!" }, status: :bad_request
  end

end
