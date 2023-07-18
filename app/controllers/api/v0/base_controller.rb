class Api::V0::BaseController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    authenticate_user || handle_bad_authentication
  end

  def authenticate_user
    @user ||= User.find_by(api_key: params[:api_key])
  end

  def handle_bad_authentication
    render json: { message: 'Invalid or missing API key' }, status: :unauthorized
  end
end
