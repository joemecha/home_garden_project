# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  set_type :users

  attributes :email_address, :api_key
end