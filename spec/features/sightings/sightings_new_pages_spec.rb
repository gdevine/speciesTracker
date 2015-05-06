require 'rails_helper'

RSpec.describe "Sighting", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  

  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to sign-in page" do
        before { visit new_sighting_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end


    describe "for superusers" do
      let!(:species) { FactoryGirl.create(:species) } 
      let!(:site) { FactoryGirl.create(:site) } 
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
        it { should have_content('Comments') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('4 errors') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end

      describe "providing invalid information" do   
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: 150.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0   
        end
        
        it "should not create a sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
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
        end
        
        it "should not create a Sighting" do
          expect{ click_button "Submit" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Sighting") }
        end
      end
           
           
      describe "with valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          find('#sites').find(:xpath, 'option[2]').select_option 
          fill_in 'sighting_datetime_sighted', with: DateTime.new(2014, 07, 11, 20, 10, 0)
          fill_in 'sighting_latitude', with: -30.0   
          fill_in 'sighting_longitude', with: 150.0   
          fill_in 'sighting_altitude', with: 150.0  
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
        end
      end
  
    end  
    
  end
  
end
