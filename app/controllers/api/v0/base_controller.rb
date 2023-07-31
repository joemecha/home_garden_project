# frozen_string_literal: true

class Api::V0::BaseController < ApplicationController
  before_action :authenticate

  private

  attr_reader :current_user

  def authenticate
    @current_user ||= User.find_by(api_key: params[:api_key])

    # If the user is not authorized, return 401 Unauthorized
    render json: { message: 'Invalid or missing API key' }, status: :unauthorized unless @current_user
  end

  # Method to handle the 401 Not Authorized response
  def render_not_authorized(message = 'Unauthorized')
    render json: { error: message }, status: :unauthorized
  end

  # Method to handle the 404 Not Found response
  def render_not_found(message = 'Not Found')
    render json: { error: message }, status: :not_found
  end
end
