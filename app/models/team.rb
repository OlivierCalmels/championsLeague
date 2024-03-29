# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team1, class_name: 'Groups', foreign_key: 'team1_id'
  has_many :team2, class_name: 'Groups', foreign_key: 'team2_id'
  has_many :team1, class_name: 'Matches', foreign_key: 'team1_id'
  has_many :team2, class_name: 'Matches', foreign_key: 'team2_id'
end
