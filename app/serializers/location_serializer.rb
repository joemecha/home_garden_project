# frozen_string_literal: true

class LocationSerializer
  include JSONAPI::Serializer
  set_type :locations

  attributes :name, :size, :irrigated
end