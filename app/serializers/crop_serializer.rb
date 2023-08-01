# frozen_string_literal: true

class CropSerializer
  include JSONAPI::Serializer
  set_type :crops

  attributes :name, :variety, :days_to_maturity, :active

  # Format the date_planted attribute as a string in "YYYY-MM-DD" format
  attribute :date_planted do |crop|
    crop.date_planted.strftime('%Y-%m-%d')
  end
  
  attribute :days_remaining_until_harvest do |crop|
    crop.active ? crop.days_remaining_until_harvest : 0
  end
end
