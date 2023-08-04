# frozen_string_literal: true

require 'securerandom'

class Api::V0::UsersController < ApplicationController
  before_action :authenticate_user!

  # TODO: add show, update, destroy and related tests

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
