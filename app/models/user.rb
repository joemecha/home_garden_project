# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :gardens, dependent: :destroy

  validates :email_address, 
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 8 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # before_save { email_address.downcase! } -- this is messing up the validation test in the model spec
end
