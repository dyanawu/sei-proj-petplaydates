class Pet < ApplicationRecord
      belongs_to :species
      belongs_to :user
      has_many :events
end
