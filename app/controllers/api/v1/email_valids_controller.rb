require 'net/http'
require 'json'

class Api::V1::EmailValidsController < Api::ApplicationController

  ACCESS_TOKEN = 'e98fc278c7d602330dfb0a3a32775a3c' #should be in a global variable

  rescue_from ActionController::ParameterMissing, with: :render_email_paramter_missing

  api :POST, '/v1/email_valid'
  description 'Check email if it already exists or it is a fake or mistyped one'
  param :email, String, desc: 'Email to be validated', required: true
  returns code: :ok, desc: 'Email Valid' do
    property :message, ["email exist :)"],
              desc: 'Validity check result in words'
    property :valid, [true, false], desc: 'Email valid flag'
  end
  returns code: :bad_request, desc: 'email parameter missing'
  returns code: :not_found, desc: 'Email Invalid' do
    property :message, ["email does not exist as an SMTP domain"],
              desc: 'Validity check result in words'
    property :valid, [false], desc: 'Email valid flag'
  end

  def create
    @email = email_param
    url = "https://apilayer.net/api/check? access_key=#{ACCESS_TOKEN}& email=#{@email}"
    uri = URI(url)
    @response = JSON.parse(Net::HTTP.get(uri))

    if validation_passed?
      render_successful_validation
    else
      render_failed_validation
    end
  end

  private

  def email_param
    params.require(:email)
  end

  def validation_passed?
    @response['smtp_check']
  end

  def render_successful_validation
    render json: {
      message: "email exist :)",
      valid: true
    }, status: :ok
  end

  def render_failed_validation
    render json: {
      message: " #{@email} does not exist as an SMTP domain",
      valid: :false
    }, status: :not_found
  end

  def render_email_paramter_missing
    render json: {
      response: "Parameter 'email' can't be blank"
    }, status: :bad_request
  end
end
