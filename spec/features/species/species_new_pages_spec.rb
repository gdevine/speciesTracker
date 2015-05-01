require 'rails_helper'

RSpec.describe "Species", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  

  describe "New page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to sign-in page" do
        before { visit new_species_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit new_species_path
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end


    describe "for superusers" do
      before do
        sign_in superuser
        visit new_species_path
      end
              
      describe "should be given access to add a new analysis type" do
        it { should have_title('Species Tracker | New Species') }
        it { should have_selector('h2', text: "Create New Species") }
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
      end
      
      describe "providing empty information" do                 
        it "should not create a new species" do
          expect{ click_button "Submit" }.to change{Species.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Create New Species") }
        end
      end

      describe "providing invalid information" do   
        before do
          fill_in 'species_genus'  , with: 'a'*81
          fill_in 'species_species'  , with: 'species text'
          fill_in 'species_common_name', with: 'a common name'   
          fill_in 'species_description', with: 'This is a description'   
        end
        
        it "should not create an analysis type" do
          expect{ click_button "Submit" }.to change{Species.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Submit" }
          it { should have_content('1 error') }
          it { should have_selector('h2', text: "Create New Species") }
        end
      end
           
      describe "with valid information" do 
        before do
          fill_in 'species_genus'  , with: 'a genus name'
          fill_in 'species_species'  , with: 'species text'
          fill_in 'species_common_name', with: 'a common name'   
          fill_in 'species_description', with: 'This is a description'   
        end
        
        it "should create a species" do
          expect { click_button "Submit" }.to change{Species.count}.by(1)
        end        
        
        describe "should revert to species view page with success message" do
          before { click_button "Submit" }
          it { should have_content('Species created!') }
          it { should have_title(full_title('Species View')) }  
          it { should have_selector('h2', "Genus") }
          it { should have_selector('h2', "Species") }
          it { should have_content('a genus name') }
          it { should have_content('species text') }
        end
      end
  
    end  
    
  end
  
end
