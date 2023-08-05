# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  respond_to :json

  def create
    build_resource(sign_up_params)
    resource.zip_code = params.dig(:user, :zip_code) # Set zip_code attribute explicitly

    if resource.save
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: {
          user: UserSerializer.new(resource).serializable_hash[:data][:attributes]
        }
      }
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :zip_code)
  end

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end
end
