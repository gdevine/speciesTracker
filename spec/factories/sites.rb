FactoryGirl.define do
  factory :site do
    name { Faker::Address.street_name }
    street { Faker::Address.street_name }
    suburb { Faker::Address.street_name }
    comments "Some comments about this particular site"
    centre_lat { Faker::Number.between(from=-90.0, to=90.0) }
    centre_lon { Faker::Number.between(from=0.0, to=360.0) } 
    centre_alt { Faker::Number.number(3) }
  end

end
