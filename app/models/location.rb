# frozen_string_literal: true

class Location < ApplicationRecord
  belongs_to :garden
  has_many :crops

  validates :name, presence: true
end
