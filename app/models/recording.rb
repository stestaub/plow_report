# frozen_string_literal: true

class Recording < ApplicationRecord
  belongs_to :driver
  validates :driver_id, uniqueness: true
end
