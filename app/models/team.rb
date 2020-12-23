class Team < ApplicationRecord
  has_many :firstTeams, :class_name => "Groups", :foreign_key => 'team1_id'
  has_many :secondTeams, :class_name => "Groups", :foreign_key => 'team2_id'
end
