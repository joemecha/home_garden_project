# frozen_string_literal: true

class LocationCrop < ApplicationRecord
  belongs_to :location
  belongs_to :crop
end
