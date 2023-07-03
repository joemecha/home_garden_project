class LocationCrop < ApplicationRecord
  belongs_to :location
  belongs_to :crop
end
