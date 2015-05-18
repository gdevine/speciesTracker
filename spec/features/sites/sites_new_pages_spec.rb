require 'rails_helper'

RSpec.describe "Site", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  

  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to sign-in page" do
        before { visit new_site_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit new_site_path
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end


    describe "for superusers" do
      before do
        sign_in superuser
        visit new_site_path
      end
              
      describe "should be given access to add a new site" do
        it { should have_title('Species Tracker | New Site') }
        it { should have_selector('h2', text: "Create New Site") }
        it { should have_content('Name') }
        it { should have_content('Street') }
        it { should have_content('Suburb') }
        it { should have_content('Centre Latitude') }
        it { should have_content('Centre Longitude') }
        it { should have_content('Centre Altitude') }
        it { should have_content('Comments') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new site" do
          expect{ click_button "Submit" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('5 errors') }
          it { should have_selector('h2', text: "Create New Site") }
        end
      end


      describe "providing invalid information" do   
        before do
          fill_in 'site_name'  , with: 'a'*81
          fill_in 'site_suburb'  , with: 'site suburb'
          fill_in 'site_centre_lat', with: -30.0   
          fill_in 'site_centre_lon', with: 150.0   
          fill_in 'site_centre_alt', with: 150.0   
        end
        
        it "should not create a site" do
          expect{ click_button "Submit" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Site") }
        end
      end
      
      
      describe "providing duplicate name" do   
        before do
          #Create a site with info that will be duplicated
          @dupsite = FactoryGirl.build(:site)
          @dupsite.name='dupname'
          @dupsite.save

          fill_in 'site_name'  , with: 'dupname'
          fill_in 'site_suburb'  , with: 'a suburb'
          fill_in 'site_centre_lat', with: -30.0   
          fill_in 'site_centre_lon', with: 150.0   
          fill_in 'site_centre_alt', with: 150.0  
        end
        
        it "should not create a Site" do
          expect{ click_button "Submit" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_content('This name already exists') }
          it { should have_selector('h2', text: "Create New Site") }
        end
      end
      
       
      describe "providing invalid co-ordinates" do   
        before do
          fill_in 'site_name'  , with: 'dupname'
          fill_in 'site_suburb'  , with: 'a suburb'
          fill_in 'site_centre_lat', with: -30.0   
          fill_in 'site_centre_lon', with: 500.0   
          fill_in 'site_centre_alt', with: 150.0  
        end
        
        it "should not create a Site" do
          expect{ click_button "Submit" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Site") }
        end
      end
           
           
      describe "with valid information" do 
        before do
          fill_in 'site_name'  , with: 'a site name'
          fill_in 'site_suburb'  , with: 'a site suburb'
          fill_in 'site_street', with: 'a street'   
          fill_in 'site_comments', with: 'This is a comment'   
          fill_in 'site_centre_lat', with: -30.010267   
          fill_in 'site_centre_lon', with: 150.063728   
          fill_in 'site_centre_alt', with: 150  
        end
        
        it "should create a site" do
          expect { click_button "Submit" }.to change{Site.count}.by(1)
        end        
        
        describe "should revert to site view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Site created!') }
          it { should have_title(full_title('Site View')) }  
          it { should have_selector('h2', "Name") }
          it { should have_selector('h2', "Suburb") }
          it { should have_content('a site name') }
          it { should have_content('a site suburb') }
          it { should have_content('-30.010267') }
          it { should have_content('150.063728') }
          it { should have_content('150') }
        end
      end
  
    end  
    
    
    describe "for admins" do
      before do
        sign_in admin
        visit new_site_path
      end
              
      describe "should be given access to add a new site" do
        it { should have_title('Species Tracker | New Site') }
        it { should have_selector('h2', text: "Create New Site") }
        it { should have_content('Name') }
        it { should have_content('Street') }
        it { should have_content('Suburb') }
        it { should have_content('Centre Latitude') }
        it { should have_content('Centre Longitude') }
        it { should have_content('Centre Altitude') }
        it { should have_content('Comments') }
      end
    
      describe "with valid information" do 
        before do
          fill_in 'site_name'  , with: 'a site name'
          fill_in 'site_suburb'  , with: 'a site suburb'
          fill_in 'site_street', with: 'a street'   
          fill_in 'site_comments', with: 'This is a comment'   
          fill_in 'site_centre_lat', with: -30.0   
          fill_in 'site_centre_lon', with: 150.0   
          fill_in 'site_centre_alt', with: 150.0  
        end
        
        it "should create a site" do
          expect { click_button "Submit" }.to change{Site.count}.by(1)
        end        
        
        describe "should revert to site view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Site created!') }
          it { should have_title(full_title('Site View')) }  
          it { should have_selector('h2', "Name") }
          it { should have_selector('h2', "Suburb") }
          it { should have_content('a site name') }
          it { should have_content('a site suburb') }
        end
      end
    
    end
    
  end
  
end
