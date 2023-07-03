class Location < ApplicationRecord
  belongs_to :garden
  has_many :location_crops
  has_many :crops, through: :location_crops

  validates :name, presence: true
end
