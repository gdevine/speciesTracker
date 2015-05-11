require 'rails_helper'

RSpec.describe "Sighting", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  let!(:species) { FactoryGirl.create(:species) } 
  
  
  describe "Edit page" do
    
    before do 
      @sighting = FactoryGirl.create(:sighting)
    end 
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit edit_sighting_path(@sighting) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    
    describe "for users who aren't a creator or spotter" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit edit_sighting_path(@sighting)
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end   
    
    
   describe "for users who created (and thus spotted) the sighting" do
      before do
        @sighting.creator = user
        @sighting.spotter = user
        @sighting.save
        sign_in user
        visit edit_sighting_path(@sighting)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Sighting') }
        it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should_not have_content('Sighted by') }
        it { should have_content('Comments') }
        it { should have_select('species', selected: @sighting.species.fullname) }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Sighting View') }
          it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        end
      end
      
      describe "providing empty species information" do   
        before do
          find('#species').find(:xpath, 'option[1]').select_option  
        end
        
        it "should not change number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        end
      end
      
      describe "with invalid co-ordinate information" do 
        before do
          fill_in 'sighting_latitude', with: 251.00
        end
        
        it "should not update a Sighting" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('must be less than or equal to 90') }
          it { should have_selector('h2', text: "Edit Sighting") }
        end
      end     
           
      describe "with valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_longitude', with: 150.02
        end
        
        it "should keep the same number of sightings" do
          expect { click_button "Update" }.to change{Sighting.count}.by(0)
        end        
        
        describe "should revert to sighting view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Sighting Updated!') }
          it { should have_content('150.02') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', text: "Sighting "+@sighting.id.to_s) }
        end
      end
  
    end  
    
    
    describe "for users who spotted but didn't create the sighting" do
      before do
        @sighting.spotter = user
        @sighting.save
        sign_in user
        visit edit_sighting_path(@sighting)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Sighting') }
        it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
      end
    
    end


    describe "for superusers who didn't create the sighting" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in superuser
          visit edit_sighting_path(@sighting)
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end       
    
    
    describe "for superusers who created the sighting" do
      before do
        @sighting.creator = superuser
        @sighting.save
        sign_in superuser
        visit edit_sighting_path(@sighting)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Sighting') }
        it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Sighted by') }
        it { should have_content('Comments') }
        it { should have_select('species', selected: @sighting.species.fullname) }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Sighting View') }
          it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        end
      end
      
      describe "providing empty species information" do   
        before do
          find('#species').find(:xpath, 'option[1]').select_option  
        end
        
        it "should not change number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        end
      end
      
      describe "with invalid co-ordinate information" do 
        before do
          fill_in 'sighting_latitude', with: 251.00
        end
        
        it "should not update a Sighting" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('must be less than or equal to 90') }
          it { should have_selector('h2', text: "Edit Sighting") }
        end
      end     
           
      describe "with valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_longitude', with: 150.02
        end
        
        it "should keep the same number of sightings" do
          expect { click_button "Update" }.to change{Sighting.count}.by(0)
        end        
        
        describe "should revert to sighting view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Sighting Updated!') }
          it { should have_content('150.02') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', text: "Sighting "+@sighting.id.to_s) }
        end
      end
  
    end  


    describe "for admins" do
      before do
        sign_in admin
        visit edit_sighting_path(@sighting)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Sighting') }
        it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        it { should have_content('Species') }
        it { should have_content('Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Sighted by') }
        it { should have_content('Comments') }
        it { should have_select('species', selected: @sighting.species.fullname) }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Sighting View') }
          it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        end
      end
      
      describe "providing empty species information" do   
        before do
          find('#species').find(:xpath, 'option[1]').select_option  
        end
        
        it "should not change number of sightings" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Edit Sighting "+@sighting.id.to_s) }
        end
      end
      
      describe "with invalid co-ordinate information" do 
        before do
          fill_in 'sighting_latitude', with: 251.00
        end
        
        it "should not update a Sighting" do
          expect{ click_button "Update" }.to change{Sighting.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('must be less than or equal to 90') }
          it { should have_selector('h2', text: "Edit Sighting") }
        end
      end     
           
      describe "with valid information" do 
        before do
          find('#species').find(:xpath, 'option[2]').select_option  
          fill_in 'sighting_longitude', with: 150.02
        end
        
        it "should keep the same number of sightings" do
          expect { click_button "Update" }.to change{Sighting.count}.by(0)
        end        
        
        describe "should revert to sighting view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Sighting Updated!') }
          it { should have_content('150.02') }
          it { should have_title(full_title('Sighting View')) }  
          it { should have_selector('h2', text: "Sighting "+@sighting.id.to_s) }
        end
      end
  
    end 
 
        
  end
 
  
end
