class Draw < ApplicationRecord
  belongs_to :tournament
  has_many :matches
end
