# frozen_string_literal: true

class GardenSerializer
  include JSONAPI::Serializer
  set_type :gardens

  attributes :name, :size
end