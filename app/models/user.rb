# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :gardens, dependent: :destroy

  validates :email, 
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 8 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # before_save { email_address.downcase! } -- this is messing up the validation test in the model spec
end
