# frozen_string_literal: true

class Tournament < ApplicationRecord
  has_many :draws
  has_many :matches, through: :draws
  has_many :groups
  has_many :teams, through: :groups, source: :team1
  has_many :teams, through: :groups, source: :team2
end
