class Event < ApplicationRecord
  has_and_belongs_to_many :pets
  belongs_to :user

  def status
    if self.start_time < Time.now
      "past"
    elsif self.pets.length >= self.capacity
      "full"
    else
      "open"
    end
  end

end
