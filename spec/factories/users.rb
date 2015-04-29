FactoryGirl.define do
    
 factory :user do
    firstname { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password "foobar100"
    password_confirmation "foobar100"   
    role "user"
    approved true
    
    factory :unapproved_user do
      approved false
    end

    factory :superuser do
      role "superuser"
    end
    
    factory :admin do
      role "admin"
    end        
  
  end
    
end