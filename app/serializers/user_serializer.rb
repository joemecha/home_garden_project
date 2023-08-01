# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  set_type :users

  attributes :name, :email_address, :api_key
end