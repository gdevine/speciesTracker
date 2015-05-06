FactoryGirl.define do
  factory :sighting do
    species
    datetime_sighted { Faker::Time.between(30.days.ago, Time.now) }
    site
    latitude  { Faker::Number.between(from=-34.0, to=-33.5) }
    longitude { Faker::Number.between(from=150.2, to=150.6) } 
    altitude { Faker::Number.number(3) }
    comments "My comments about this sighting"
    spotter  
    creator
  end
end

# 
# 
# factory :pd_request do
    # association :employee, :factory => :employee_with_supervisor
    # description { Faker::Lorem.words.join(' ') }
    # start_date 7.days.from_now
# 
    # trait :approved do
      # status 'Approved'
      # name 'Lorem Ipsum...'
      # association :approving_manager, :factory => :employee  # I'm assuming this can be a new employee
# 
      # after(:build) do |pd_request|
        # pd_request.approving_supervisor = pd_request.employee.supervisor
      # end
    # end
  # end
