# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :draw
  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'
end
