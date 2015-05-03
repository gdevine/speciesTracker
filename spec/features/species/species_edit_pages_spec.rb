require 'rails_helper'

RSpec.describe "Species", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Edit page" do
    
    before do 
      @species = FactoryGirl.create(:species)
    end 
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit edit_species_path(@species) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      describe "should be redirected to home page with access error message" do
        before do 
          sign_in user
          visit edit_species_path(@species)
        end
        it { should have_title('Species Tracker | Home') }
        it { should have_content("You are not authorized to access this page.") }
      end
    end    
   
    
    describe "for superusers" do
      before do
        sign_in superuser
        visit edit_species_path(@species)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Species') }
        it { should have_selector('h2', text: "Edit Species "+@species.id.to_s) }
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of speciess" do
          expect{ click_button "Update" }.to change{Species.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Species View') }
          it { should have_selector('h2', text: "Species " + @species.id.to_s) }
        end
      end
      
      describe "providing empty information" do   
        before do
          fill_in 'species_genus'  , with: ''
          fill_in 'species_species'  , with: ''
          fill_in 'species_common_name', with: ''              
          fill_in 'species_description', with: ''              
        end
        
        it "should not change number of species" do
          expect{ click_button "Update" }.to change{Species.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Edit Species "+@species.id.to_s) }
        end
      end
      
      describe "providing duplicate genus-species" do   
        before do
          #Create a species with info that will be duplicated
          @dupspecies = FactoryGirl.build(:species)
          @dupspecies.genus='dupgenus'
          @dupspecies.species='dupspecies'
          @dupspecies.save

          fill_in 'species_genus'  , with: 'dupgenus'
          fill_in 'species_species'  , with: 'dupspecies'
          fill_in 'species_common_name', with: 'a common name'   
          fill_in 'species_description', with: 'This is a description'   
        end
        
        it "should not create a Species" do
          expect{ click_button "Update" }.to change{Species.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('1 error') }
          it { should have_content('This genus-species already exists') }
          it { should have_selector('h2', text: "Edit Species") }
        end
      end
           
           
      describe "with valid information" do 
        before do
          fill_in 'species_genus'  , with: 'genusxx'
          fill_in 'species_species'  , with: 'speciesyy'
          fill_in 'species_common_name', with: 'common name zz'
        end
        
        it "should keep the same number of species" do
          expect { click_button "Update" }.to change{Species.count}.by(0)
        end        
        
        describe "should revert to species view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Species Updated!') }
          it { should have_content('genusxx') }
          it { should have_content('speciesyy') }
          it { should have_content('common name zz') }
          it { should have_title(full_title('Species View')) }  
          it { should have_selector('h2', text: "Species "+@species.id.to_s) }
        end
      end
  
    end  


   describe "for admins" do
      before do
        sign_in admin
        visit edit_species_path(@species)
      end
              
      describe "should be given access to edit job" do
        it { should have_title('Species Tracker | Edit Species') }
        it { should have_selector('h2', text: "Edit Species "+@species.id.to_s) }
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
      end
      
      describe "not changing any information" do                 
        it "should not change the number of speciess" do
          expect{ click_button "Update" }.to change{Species.count}.by(0)
        end             
        
        describe "should return to view" do
          before { click_button "Update" }
          it { should have_title('Species View') }
          it { should have_selector('h2', text: "Species " + @species.id.to_s) }
        end
      end
      
      describe "providing empty information" do   
        before do
          fill_in 'species_genus'  , with: ''
          fill_in 'species_species'  , with: ''
          fill_in 'species_common_name', with: ''              
          fill_in 'species_description', with: ''              
        end
        
        it "should not change number of species" do
          expect{ click_button "Update" }.to change{Species.count}.by(0)
        end             
        
        describe "should return an error and revert back" do
          before { click_button "Update" }
          it { should have_content('2 errors') }
          it { should have_selector('h2', text: "Edit Species "+@species.id.to_s) }
        end
      end
           
      describe "with valid information" do 
        before do
          fill_in 'species_genus'  , with: 'genusxx'
          fill_in 'species_species'  , with: 'speciesyy'
          fill_in 'species_common_name', with: 'common name zz'
        end
        
        it "should keep the same number of species" do
          expect { click_button "Update" }.to change{Species.count}.by(0)
        end        
        
        describe "should revert to species view page with success message and updated info" do
          before { click_button "Update" }
          it { should have_content('Species Updated!') }
          it { should have_content('genusxx') }
          it { should have_content('speciesyy') }
          it { should have_content('common name zz') }
          it { should have_title(full_title('Species View')) }  
          it { should have_selector('h2', text: "Species "+@species.id.to_s) }
        end
      end
  
    end  
        
  end
 
  
end
