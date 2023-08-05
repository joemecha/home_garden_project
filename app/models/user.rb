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
  
  before_validation :set_time_zone_from_zip_code, on: :create
  validates :zip_code, presence: true, format: { with: /\A\d{5}\z/, message: "should be a valid US zip code" }


  private

  def set_time_zone_from_zip_code
    return unless zip_code.present?
    
    coordinates = Geocoder.coordinates(zip_code)
    
    if coordinates
      time_zone = Timezone.lookup(coordinates[0], coordinates[1])
      self.time_zone = time_zone.name if time_zone.present?
      puts "Coordinates: #{coordinates}"
      puts "Time zone: #{self.time_zone}"
    end
  end
end
