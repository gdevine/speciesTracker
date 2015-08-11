require 'rails_helper'

RSpec.describe "Sighting", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  let!(:species) { FactoryGirl.create(:species) } 
  let!(:site) { FactoryGirl.create(:site) } 
  

  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to sign-in page" do
        before { visit new_sighting_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end


    describe "for users" do
      before do
        sign_in user
        visit new_sighting_path  
      end
              
      describe "should be given access to add a new sighting" do
        it { should have_title('Species Tracker | New Sighting') }
        it { should have_selector('h2', text: "Create New Sighting") }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Photo') }
        it { should_not have_content('Sighted by') }
        it { should have_content('Comments') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('2 errors') }
          
          it { should have_content('You must select a Species') }
          it { should have_content('If a Site is not selected, then a specific latitude/longitude must be given') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
      
      describe "not providing a date time of sighting" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: ''
          fill_in 'sighting_latitude', with: -50.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150   
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content('You must state when a sighting was made') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
      
      describe "providing a datetime in the future" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2016, 12, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -50.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150   
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content('Date/Time of sighting can not be in the future') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
       
      describe "providing invalid co-ordinates" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: 150.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content("must be less than or equal to 90") }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
      
      describe "not providing a site but providing invalid co-ordinates" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: ''   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150.012345  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content("If providing latitude/longitude, both must be present") }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
      
      describe "not providing a site but providing valid co-ordinates" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[1]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -33.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150.0  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(1)
        end             
        
        describe "should revert to sighting view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Sighting created!') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', "Species") }
          it { should have_selector('h2', "Site") }
          it { should have_content(species.fullname) }
          it { should have_content('None given') }
          it { should have_content('-33.012345') }
          it { should have_content('150.012345') }
        end
      end
      
      describe "with valid information but without a photo" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -30.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150.012345  
        end
        
        it "should create a sighting" do
          expect { click_button "Submit" }.to change{Sighting.count}.by(1)
        end        
        
        describe "should revert to sighting view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Sighting created!') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', "Species") }
          it { should have_selector('h2', "Site") }
          it { should have_content(species.fullname) }
          it { should have_content(site.name) }
          it { should have_content('-30.01234') }
          it { should have_content('150.012345') }
        end
      end
           
      describe "with fully valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -30.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150 
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should create a sighting" do
          expect { click_button "Submit" }.to change{Sighting.count}.by(1)
        end        
        
        describe "should revert to sighting view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Sighting created!') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', "Species") }
          it { should have_selector('h2', "Site") }
          it { should have_content(species.fullname) }
          it { should have_content(site.name) }
          it { should have_content('-30.01234') }
          it { should have_content('150.012345') }
        end
      end
  
    end  
    
    
    describe "for superusers" do
      user1 = FactoryGirl.create(:user)
      user1.firstname='harry'
      user1.surname='houdini'
      user1.save
      before do
        sign_in superuser
        visit new_sighting_path  
      end
              
      describe "should be given access to add a new sighting" do
        it { should have_title('Species Tracker | New Sighting') }
        it { should have_selector('h2', text: "Create New Sighting") }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Sighted by') }
        it { should have_content('Comments') }
        it { should have_content('Photo') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('2 errors') }
          
          it { should have_content('You must select a Species') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end

      describe "providing a datetime in the future" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2016, 12, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -50.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0   
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content('Date/Time of sighting can not be in the future') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
       
      describe "providing invalid co-ordinates" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: 150.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should not create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content("must be less than or equal to 90") }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
           
      describe "with valid information not changing the 'sighted by' selection" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -30.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150.0  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should create a sighting" do
          expect { click_button "Submit" }.to change{Sighting.count}.by(1)
        end        
        
        describe "should revert to sighting view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Sighting created!') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', "Species") }
          it { should have_selector('h2', "Site") }
          it { should have_content(species.fullname) }
          it { should have_content(superuser.fullname) }
          it { should have_content(site.name) }
          it { should have_content('-30.012345') }
          it { should have_content('150.012345') }
        end
      end
  
    end  
    
    
    describe "for admins" do
      before do
        sign_in admin
        visit new_sighting_path  
      end
              
      describe "should be given access to add a new sighting" do
        it { should have_title('Species Tracker | New Sighting') }
        it { should have_selector('h2', text: "Create New Sighting") }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Sighted by') }
        it { should have_content('Comments') }
        it { should have_content('Photo') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('2 errors') }
          
          it { should have_content('You must select a Species') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end

      describe "providing a datetime in the future" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2016, 12, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -50.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg") 
        end
        
        it "should not create a sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content('Date/Time of sighting can not be in the future') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
       
      describe "providing invalid co-ordinates" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: 150.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0 
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg") 
        end
        
        it "should not create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content("must be less than or equal to 90") }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
           
      describe "with valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -30.012345   
          fill_in 'sighting_longitude', with: 150.012345   
          fill_in 'sighting_altitude', with: 150.0  
          attach_file "sighting_photo", Rails.root.join("db/seed_photos/ST_Plant.jpg")
        end
        
        it "should create a sighting" do
          expect { click_button "Submit" }.to change{Sighting.count}.by(1)
        end        
        
        describe "should revert to sighting view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Sighting created!') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', "Species") }
          it { should have_selector('h2', "Site") }
          it { should have_content(species.fullname) }
          it { should have_content(site.name) }
          it { should have_content('-30.012345') }
          it { should have_content('150.012345') }
        end
      end
  
    end  
    
  end
  
end
