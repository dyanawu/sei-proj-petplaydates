json.extract! pet, :id, :name, :dp_url, :species, :birthday, :bio, :created_at, :updated_at
json.url pet_url(pet, format: :json)
