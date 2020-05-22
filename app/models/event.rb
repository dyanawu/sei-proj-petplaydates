class Event < ApplicationRecord
require 'action_view'
  require 'action_view/helpers'
  include ActionView::Helpers::DateHelper

  has_and_belongs_to_many :pets
  belongs_to :user
  belongs_to :type

  def status
    if self.end_time < Time.now
      "past"
    elsif self.start_time < Time.now
      "started"
    elsif self.pets.length >= self.capacity
      "full"
    else
      "open"
    end
  end

  def time_left
    time_ago_in_words(self.start_time)
  end

  def ended_since
    time_ago_in_words(self.end_time)
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
