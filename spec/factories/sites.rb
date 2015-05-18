FactoryGirl.define do
  factory :site do
    name { Faker::Address.street_name }
    street { Faker::Address.street_name }
    suburb { Faker::Address.street_name }
    comments "Some comments about this particular site"
    centre_lat { Faker::Number.between(from=-34.014523, to=-33.554234) }
    centre_lon { Faker::Number.between(from=150.265234, to=150.653986) } 
    centre_alt { Faker::Number.number(3) }
  end
end
