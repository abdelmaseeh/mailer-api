class Api::ApplicationController < ActionController::API
  rescue_from Exception, with: :render_exception_response

  def render_exception_response
    render json: { response: "something went wrong" }, status: :unprocessable_entity
  end
end
