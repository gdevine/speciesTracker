FactoryGirl.define do
  factory :sighting do
    species
    datetime_sighted { rand(1.year.ago..Time.now).to_datetime }
    site
    latitude  { Faker::Number.between(from=-34.0, to=-33.5) }
    longitude { Faker::Number.between(from=150.2, to=150.6) } 
    altitude { Faker::Number.number(3) }
    comments "My comments about this sighting"
    spotter  
    creator
    photo File.new("#{Rails.root}/db/seed_photos/ST_Plant.jpg")
  end
end