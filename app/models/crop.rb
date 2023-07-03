class Crop < ApplicationRecord
  belongs_to :location
  has_many :notes

  validates :name, presence: true
  validates :date_planted, presence: true
  validates :days_to_maturity, presence: true
end
