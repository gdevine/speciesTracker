FactoryGirl.define do
  factory :species do
    genus { Faker::Lorem.word }
    species { Faker::Lorem.word }
    common_name { Faker::Name.last_name }
    description "This is a description of this particular species"
  end
end
