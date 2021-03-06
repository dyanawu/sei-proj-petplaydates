class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one :profile, dependent: :destroy
  has_many :pets, dependent: :destroy
  has_many :events, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # returns events that the user's pets are attending
  def events_attending
    Event.joins(:pets).where(pets: {user_id: self.id}).distinct.order(:start_time)
  end

  # returns all events, attending or hosting
  def events_all
    self.events_attending.union(self.events).distinct
  end

  def events_future
    self.events_all.where(
      "start_time > ?", Time.now)
      .order(start_time: :asc)
  end

  def events_past
    self.events_all.where(
      "end_time < ?", Time.now)
      .order(start_time: :desc)
  end

end
