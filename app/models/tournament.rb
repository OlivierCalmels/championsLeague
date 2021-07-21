class Tournament < ApplicationRecord
  has_many :draws
  has_many :groups
end
