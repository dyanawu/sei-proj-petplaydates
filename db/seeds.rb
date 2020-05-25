# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


## Fixed species table
['dog', 'cat'].each do |s|
    Species.create(name: s)
end

25.times{print"-"}
puts

## Fake Users [username: firstname, email: firstname@email.com, password: 123456]
20.times do
    name = Faker::Name.first_name.downcase
    User.create! :username => "#{name}", :email => "#{name}@email.com", :password => "123456", :password_confirmation => "123456"

    puts "Created user called #{name} with email #{name}@email.com"
end

25.times{print"-"}
puts

## Fake user profiles for each user
User.all.each do |user|
    puts "Created profile for #{user.username}"
    Profile.create(user_id: user.id, dp_url: "https://loremflickr.com/400/400/#{user.username}?lock=#{user.id}", bio: Faker::Lorem.paragraph, location: Faker::Address.street_address, gender: Faker::Gender.short_binary_type, birthday:"#{rand(1950..2000)}-#{rand(1..12)}-#{rand(1-28)}", name: "#{user.username}")
end

25.times{print"-"}
puts

## Fake Pets for random users
36.times do

  pet = Pet.create(name: Faker::Name.first_name, species_id: rand(1..2), birthday: "#{rand(1990..2019)}-#{rand(1..12)}-#{rand(1-28)}", bio: Faker::Lorem.paragraph, gender: Faker::Gender.short_binary_type, user_id: rand(User.first.id..User.last.id))
  if pet.species_id == 1
    pet.update(dp_url: "https://loremflickr.com/400/400/puppy?lock=#{pet.id}")
  else
    pet.update(dp_url: "https://loremflickr.com/400/400/kitten?lock=#{pet.id}")
  end

  puts "Created #{pet.name} the #{pet.species.name} (#{pet.gender}) belonging to #{pet.user.username} (user id: #{pet.user.id})"
end

25.times{print"-"}
puts

## Event type table
['park', 'cafe hangout', 'walk', 'home date'].each do |t|
  Type.create(name: t)
end

## Generate fake events under random users (park events)
10.times do
    user = User.find(rand(User.first.id..User.last.id))

    # Starts on a random date/time 28 days before or after today
    start_time = DateTime.now + rand(-28..28) + rand(-24..24).hours

    #End time is 1 to 4 hours after start time.
    #Event is named after user. E.g. "chelsea's event"

    event = Event.create(user_id: user.id, title: "#{user.username}'s event", description: Faker::Lorem.paragraph, capacity: rand(2..20), location: Faker::Address.street_address, start_time: start_time, end_time: start_time + rand(1..4).hours, min_pets: 0, type_id: 1)
    event.update(img_url: "https://loremflickr.com/400/400/park?lock=#{event.id}")

    puts "Created #{event.title}"
end

## Generate fake events under random users (cafe events)
10.times do
    user = User.find(rand(User.first.id..User.last.id))

    # Starts on a random date/time 28 days before or after today
    start_time = DateTime.now + rand(-28..28) + rand(-24..24).hours

    #End time is 1 to 4 hours after start time.
    #Event is named after user. E.g. "chelsea's event"

    event = Event.create(user_id: user.id, title: "#{user.username}'s event", description: Faker::Lorem.paragraph, capacity: rand(2..20), location: Faker::Address.street_address, start_time: start_time, end_time: start_time + rand(1..4).hours, min_pets: 0, type_id: 2)
    event.update(img_url: "https://loremflickr.com/400/400/cafe?lock=#{event.id}")

    puts "Created #{event.title}"
end

## Generate fake events under random users (walk events)
10.times do
    user = User.find(rand(User.first.id..User.last.id))

    # Starts on a random date/time 28 days before or after today
    start_time = DateTime.now + rand(-28..28) + rand(-24..24).hours

    #End time is 1 to 4 hours after start time.
    #Event is named after user. E.g. "chelsea's event"

    event = Event.create(user_id: user.id, title: "#{user.username}'s event", description: Faker::Lorem.paragraph, capacity: rand(2..20), location: Faker::Address.street_address, start_time: start_time, end_time: start_time + rand(1..4).hours, min_pets: 0, type_id: 3)
    event.update(img_url: "https://loremflickr.com/400/400/walk?lock=#{event.id}")

    puts "Created #{event.title}"
end

25.times{print"-"}
puts

## Link random pets to random events.
100.times do
    event = Event.find(rand(Event.first.id..Event.last.id))
    pet = Pet.find(rand(Pet.first.id..Pet.last.id))
    event.pets << pet
    puts "Added #{pet.name} to #{event.title}"
end
