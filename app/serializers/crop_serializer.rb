# frozen_string_literal: true

class CropSerializer
  include JSONAPI::Serializer
  set_type :crops

  attributes :name, :variety, :days_to_maturity, :date_planted, :active
end