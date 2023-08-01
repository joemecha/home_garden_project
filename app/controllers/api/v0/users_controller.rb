# frozen_string_literal: true

require 'securerandom'

class Api::V0::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create]

  def create
    if params[:user][:email_address].blank?
      render json: { errors: 'Email address cannot be blank' }, status: :bad_request
    elsif params[:user][:password] != params[:user][:password_confirmation]
      render json: { errors: 'Passwords do not match' }, status: :bad_request
    else
      user = User.create(user_params)
      user.update(api_key: SecureRandom.hex)

      render json: UserSerializer.new(user), status: :created
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
