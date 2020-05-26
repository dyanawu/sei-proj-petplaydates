# coding: utf-8
class Pet < ApplicationRecord
      belongs_to :species
      has_and_belongs_to_many :events
      belongs_to :user

      validates :name, presence: true, length: {minimum: 2, maximum: 100}
      validates :bio, presence: true, length: {minimum: 2, maximum: 400}
      validates :birthday, presence: true

      def is_rsvped(event)
          if self.events.include?(event)
            return true
          else
            return false
          end
      end

      def events_future
        self.events.where(
          "start_time > ?", Time.now)
          .order(start_time: :asc)
      end

      def events_past
        self.events.where(
          "end_time < ?", Time.now)
          .order(start_time: :desc)
      end

      def gender_symbol
        if self.gender == "f"
          "♀︎"
        elsif self.gender == "m"
          "♂︎"
        end
      end

end
