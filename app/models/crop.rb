class Crop < ApplicationRecord
  has_many :location_crops
  has_many :locations, through: :location_crops
  has_many :notes

  validates :name, presence: true
  validates :date_planted, presence: true
  validates :days_to_maturity, presence: true
end
