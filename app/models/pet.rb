class Pet < ApplicationRecord
      belongs_to :species
      has_and_belongs_to_many :events
      belongs_to :user

      validates :name, presence: true, length: {minimum: 2, maximum: 100}
      validates :bio, presence: true, length: {minimum: 2, maximum: 400}
      validates :birthday, presence: true
end
