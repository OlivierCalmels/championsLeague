class Group < ApplicationRecord
  belongs_to :tournament
  belongs_to :team1, :class_name => 'Team'
  belongs_to :team2, :class_name => 'Team'
end
