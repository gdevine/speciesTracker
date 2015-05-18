FactoryGirl.define do
  factory :sighting do
    species
    datetime_sighted { rand(1.year.ago..Time.now).to_datetime }
    site
    latitude  { Faker::Number.between(from=-34.012345, to=-33.543210) }
    longitude { Faker::Number.between(from=150.212345, to=150.612345) } 
    altitude { Faker::Number.number(3) }
    comments "My comments about this sighting"
    spotter  
    creator
    photo File.new("#{Rails.root}/db/seed_photos/ST_Plant.jpg")
  end
end