require 'securerandom'

class Api::V0::UsersController < ApplicationController
  def create
    if params[:email_address].blank?
      render json: { errors: 'Email address cannot be blank' }, status: :bad_request
    elsif params[:password] != params[:password_confirmation]
      render json: { errors: 'Passwords do not match' }, status: :bad_request
    else
      user = User.create(user_params)
      user.update(api_key: SecureRandom.hex)
      render json: UserSerializer.new(user), status: :created
    end
  end

  private

  def user_params
    params.permit(:email_address, :password, :password_confirmation)
  end
end
