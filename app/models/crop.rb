# frozen_string_literal: true

class Crop < ApplicationRecord
  belongs_to :location
  has_many :notes, dependent: :destroy

  validates :name, presence: true
  validates :date_planted, presence: true
  validates :days_to_maturity, presence: true

  # Calculate days remaining until harvest
  def days_remaining_until_harvest
    # WIP
    # maturity_date = created_at + days_to_maturity
    remaining_days = (maturity_date - Date.current).to_i

    # If the crop has already matured or maturity date is in the past, return 0
    remaining_days >= 0 ? remaining_days : 0
  end
end
