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

  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "should be a valid US zip code" }
end
