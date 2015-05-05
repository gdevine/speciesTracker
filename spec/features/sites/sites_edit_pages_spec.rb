require 'rails_helper'

RSpec.describe "Site", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Edit page" do
    
    before do 
      @site = FactoryGirl.create(:site)
    end 
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit edit_site_path(@site) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit edit_site_path(@site)
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end    
   
    
    describe "for superusers" do
      before do
        sign_in superuser
        visit edit_site_path(@site)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Site') }
        it { should have_selector('h2', text: "Edit Site "+@site.id.to_s) }
        it { should have_content('Name') }
        it { should have_content('Street') }
        it { should have_content('Suburb') }
        it { should have_content('Comments') }
        it { should have_content('Centre Latitude') }
        it { should have_content('Centre Longitude') }
        it { should have_content('Centre Altitude') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of sites" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Site View') }
          it { should have_selector('h2', text: "Site " + @site.id.to_s) }
        end
      end
      
      describe "providing empty information" do   
        before do
          fill_in 'site_name'  , with: ''
          fill_in 'site_suburb'  , with: ''
        end
        
        it "should not change number of sites" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Edit Site "+@site.id.to_s) }
        end
      end
      
      describe "providing duplicate name" do   
        before do
          #Create a site with info that will be duplicated
          @dupsite = FactoryGirl.build(:site)
          @dupsite.name='dupname'
          @dupsite.save

          fill_in 'site_name'  , with: 'dupname'
          fill_in 'site_suburb'  , with: 'dupsuburb'
        end
        
        it "should not update a Site" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('This name already exists') }
          it { should have_selector('h2', text: "Edit Site") }
        end
      end
      
      describe "with invalid co-ordinate information" do 
        before do
          fill_in 'site_name'  , with: 'namexx'
          fill_in 'site_suburb'  , with: 'suburbyy'
          fill_in 'site_centre_lat', with: 251.00
          fill_in 'site_centre_lon', with: 33.02
          fill_in 'site_centre_alt', with: 255.00
        end
        
        it "should not update a Site" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('must be less than or equal to 90') }
          it { should have_selector('h2', text: "Edit Site") }
        end
      end     
           
      describe "with valid information" do 
        before do
          fill_in 'site_name'  , with: 'namexx'
          fill_in 'site_suburb'  , with: 'suburbyy'
          fill_in 'site_centre_lat', with: -33.00
          fill_in 'site_centre_lon', with: 150.02
          fill_in 'site_centre_alt', with: 255.00
        end
        
        it "should keep the same number of sites" do
          expect { click_button "Update" }.to change{Site.count}.by(0)
        end        
        
        describe "should revert to site view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Site Updated!') }
          it { should have_content('namexx') }
          it { should have_content('suburbyy') }
          it { should have_content('150.02') }
          it { should have_content('-33.00') }
          it { should have_title(full_title('Site View')) }  
          it { should have_selector('h2', text: "Site "+@site.id.to_s) }
        end
      end
  
    end  


    describe "for admins" do
      before do
        sign_in admin
        visit edit_site_path(@site)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Site') }
        it { should have_selector('h2', text: "Edit Site "+@site.id.to_s) }
        it { should have_content('Name') }
        it { should have_content('Street') }
        it { should have_content('Suburb') }
        it { should have_content('Comments') }
        it { should have_content('Centre Latitude') }
        it { should have_content('Centre Longitude') }
        it { should have_content('Centre Altitude') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of sites" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Site View') }
          it { should have_selector('h2', text: "Site " + @site.id.to_s) }
        end
      end
      
      describe "providing empty information" do   
        before do
          fill_in 'site_name'  , with: ''
          fill_in 'site_suburb'  , with: ''
        end
        
        it "should not change number of sites" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Edit Site "+@site.id.to_s) }
        end
      end
      
      describe "providing duplicate name" do   
        before do
          #Create a site with info that will be duplicated
          @dupsite = FactoryGirl.build(:site)
          @dupsite.name='dupname'
          @dupsite.save

          fill_in 'site_name'  , with: 'dupname'
          fill_in 'site_suburb'  , with: 'dupsuburb'
        end
        
        it "should not update a Site" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('This name already exists') }
          it { should have_selector('h2', text: "Edit Site") }
        end
      end
      
      describe "with invalid co-ordinate information" do 
        before do
          fill_in 'site_name'  , with: 'namexx'
          fill_in 'site_suburb'  , with: 'suburbyy'
          fill_in 'site_centre_lat', with: 253.02
          fill_in 'site_centre_lon', with: 250.02
          fill_in 'site_centre_alt', with: 255.00
        end
        
        it "should not update a Site" do
          expect{ click_button "Update" }.to change{Site.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('must be less than or equal to 90') }
          it { should have_selector('h2', text: "Edit Site") }
        end
      end     
           
      describe "with valid information" do 
        before do
          fill_in 'site_name'  , with: 'namexx'
          fill_in 'site_suburb'  , with: 'suburbyy'
          fill_in 'site_centre_lat', with: -33.02
          fill_in 'site_centre_lon', with: 151.00
          fill_in 'site_centre_alt', with: 255.00
        end
        
        it "should keep the same number of sites" do
          expect { click_button "Update" }.to change{Site.count}.by(0)
        end        
        
        describe "should revert to site view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Site Updated!') }
          it { should have_content('namexx') }
          it { should have_content('suburbyy') }
          it { should have_content('151.00') }
          it { should have_content('-33.02') }
          it { should have_title(full_title('Site View')) }  
          it { should have_selector('h2', text: "Site "+@site.id.to_s) }
        end
      end
  
    end 
 
        
  end
 
  
end
