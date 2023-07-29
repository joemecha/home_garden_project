# frozen_string_literal: true

class NoteSerializer
  include JSONAPI::Serializer
  set_type :notes

  attributes :body
end