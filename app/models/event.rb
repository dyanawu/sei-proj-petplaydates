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

  validate :end_after_start
  validates :start_time, :end_time, :presence => true

  private
    def end_after_start
      return if end_time.blank? || start_time.blank?
    
      if end_time < start_time + 30.minutes
        errors.add(:end_time, "must be at least 30 mins after the start time") 
      end 
    end
end
