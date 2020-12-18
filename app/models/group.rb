class Group < ApplicationRecord
  belongs_to :tournament
  belongs_to :first_team
  belongs_to :second_team
end
