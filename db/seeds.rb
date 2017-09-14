# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

require 'factory_girl'
require 'csv'

# Users

# Create different types of user for developer to work with
User.create(firstname:'Gerard-User', surname:'Devine', email:'g.user@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'user')
User.create(firstname:'Gerard-Super', surname:'Devine', email:'g.superuser@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'superuser')
User.create(firstname:'Gerard-Admin', surname:'Devine', email:'g.admin@uws.edu.au', password:'qwertyui', password_confirmation:'qwertyui', approved:true, role:'admin')
User.create(firstname:'Paul', surname:'Rymer', email:'p.rymer@uws.edu.au', password:'password', password_confirmation:'password', approved:true, role:'admin')
User.create(firstname:'Desi', surname:'Quintans', email:'d.quintans@uws.edu.au', password:'password', password_confirmation:'password', approved:true, role:'admin')
User.create(firstname:'Demo', surname:'User_1', email:'demouser_1@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_2', email:'demouser_2@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_3', email:'demouser_3@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_4', email:'demouser_4@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_5', email:'demouser_5@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_6', email:'demouser_6@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_7', email:'demouser_7@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_8', email:'demouser_8@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_9', email:'demouser_9@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_10', email:'demouser_10@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_11', email:'demouser_11@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_12', email:'demouser_12@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_13', email:'demouser_13@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_14', email:'demouser_14@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_15', email:'demouser_15@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_16', email:'demouser_16@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_17', email:'demouser_17@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_18', email:'demouser_18@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_19', email:'demouser_19@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')
User.create(firstname:'Demo', surname:'User_20', email:'demouser_20@peastracker.com', password:'password', password_confirmation:'password', approved:true, role:'user')

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


# Read actual Sites data from CSV file
csv_text = File.read(Rails.root.join('lib', 'seeds', 'peas_bats_sites.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  t = Site.new
  t.name = row['name']
  t.street = row['street']
  t.suburb = row['suburb']
  t.comments = row['comments']
  t.centre_lat = row['centre_lat']
  t.centre_lon = row['centre_lon']
  if !t.valid?
    puts t.errors.full_messages
    puts '******************'
  else
    t.save
    puts "#{t.name}, #{t.street} saved"
  end
end

puts "There are now #{Site.count} rows in the sites table"


# Read actual species data from CSV file
csv_text = File.read(Rails.root.join('lib', 'seeds', 'peas_bats_species.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  s = Species.new
  s.genus = row['genus']
  s.species = row['species']
  s.common_name = row['common_name']
  s.description = row['description']
  if !s.valid?
    puts s.errors.full_messages
    puts '******************'
  else
    s.save
    puts "#{s.genus}, #{s.species} saved"
  end
end

puts "There are now #{Species.count} rows in the species table"


# Read actual sightings data from CSV file
csv_text = File.read(Rails.root.join('lib', 'seeds', 'peas_bats_sightings.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
  p = Sighting.new
  p.datetime_sighted = row['datetime_sighted'].to_datetime
  p.species = Species.where(genus: row['genus'], species: row['species']).first
  p.site = Site.where(street: row['street'], suburb: row['suburb']).first
  p.spotter = User.where(firstname: 'Desi').first
  p.creator = User.where(firstname: 'Desi').first
  p.latitude = row['latitude']
  p.longitude = row['longitude']
  p.dom_reproductive_stage = row['dom_reproductive_stage']
  p.healthy_flowers = row['healthy_flowers']
  p.healthy_pods = row['healthy_pods']
  p.adult_abundance = row['adult_abundance']
  if !p.valid?
    puts row['genus'], row['species']
    puts p.errors.full_messages
    puts '***************'
  else
    p.save
    puts "#{p.species}, #{p.datetime_sighted} saved"
  end
end

puts "There are now #{Sighting.count} rows in the sightings table"
