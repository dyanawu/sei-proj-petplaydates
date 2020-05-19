json.extract! event, :id, :title, :description, :capacity, :location, :start_time, :end_time, :min_pets, :created_at, :updated_at
json.url event_url(event, format: :json)
