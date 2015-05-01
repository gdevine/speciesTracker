# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'factory_girl'

# Users

# Create different types of user for developer to work with
User.create(firstname:'Gerard-User', surname:'Devine', email:'g.user@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'user')
User.create(firstname:'Gerard-Super', surname:'Devine', email:'g.superuser@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'superuser')
User.create(firstname:'Gerard-Admin', surname:'Devine', email:'g.admin@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'admin')
User.create(firstname:'Gerard-Unapproved', surname:'Devine', email:'g.unapproved@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:false, role:'user')

# Create some approved users
5.times do
  FactoryGirl.create :user
end

# Create one unapproved user
FactoryGirl.create :unapproved_user

# Create some superusers
2.times do
  FactoryGirl.create :superuser
end

# Create an admin user
FactoryGirl.create :admin


# Create some species
10.times do
  FactoryGirl.create :species
end
