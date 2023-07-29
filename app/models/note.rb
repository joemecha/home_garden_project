# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :crop

  validates :body, presence: true
end
