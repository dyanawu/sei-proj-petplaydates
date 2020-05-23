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
    start_time = self.start_time
    if start_time < Time.now
      time_ago_in_words(start_time) + " ago"
    else
      "in " + time_ago_in_words(start_time)
    end
  end

  def ended_since
    time_ago_in_words(self.end_time)
  end

  def start_datetime
    self.start_time.getlocal.strftime("%d %B %Y, %I:%M %p")
  end

  def end_datetime
    self.end_time.getlocal.strftime("%d %B %Y, %I:%M %p")
  end

  def start_date_str
    self.start_date.getlocal.strftime("%d %B %Y")
  end

  def start_time_str
    self.start_time.getlocal.strftime("%I:%M %p")
  end

  def end_date_str
    self.end_date.getlocal.strftime("%d %B %Y")
  end

  def end_time_str
    self.end_time.getlocal.strftime("%I:%M %p")
  end

  def self.today
    self.where(
      start_time: Time.now..Time.now.end_of_day)
      .order(start_time: :asc)
  end

  def self.upcoming
    self.where(
      start_time: Time.now.beginning_of_day + 1.day..Time.now.beginning_of_day + 8.days)
      .order(start_time: :asc)
  end

  def self.recent
    self.order(id: :desc).limit(15)
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
