# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :draws
  has_many :matches, through: :draws
  has_many :groups
end
