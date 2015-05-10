require 'rails_helper'

RSpec.describe "Sighting", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Index Map page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit map_sightings_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      before { sign_in user }
      
      describe "with no sightings in the system" do
        before { visit map_sightings_path }
        
        it { should have_title('Sightings') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Sightings") }
        it "should have an information message" do
          expect(page).to have_content('No Sightings found')
        end
        #With no sightings neither toggle button should show
        it { should_not have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
      end
    
      describe "with sightings in the system" do
        before do 
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit map_sightings_path
        end

        it { should have_selector('div#map')}
        it { should have_link('View List Mode') }
      
      end
    end
    
    
    describe "for superusers" do
      before { sign_in superuser }
      
      describe "with no sightings in the system" do
        before { visit map_sightings_path }
        
        it { should have_title('Sightings') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Sightings") }
        it "should have an information message" do
          expect(page).to have_content('No Sightings found')
        end
        #With no sightings neither toggle button should show
        it { should_not have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
      end
    
      describe "with sightings in the system" do
        before do 
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit map_sightings_path
        end

        it { should have_selector('div#map')}
        it { should have_link('View List Mode') }
        
        # Limited in what we can test within the google maps with rspec
      
      end
    end
    
   describe "for admins" do
      before { sign_in admin }
      
      describe "with no sightings in the system" do
        before { visit map_sightings_path }
        
        it { should have_title('Sightings') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Sightings") }
        it "should have an information message" do
          expect(page).to have_content('No Sightings found')
        end
        #With no sightings neither toggle button should show
        it { should_not have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
      end
    
      describe "with sightings in the system" do
        before do 
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit map_sightings_path
        end

        it { should have_selector('div#map')}
        it { should have_link('View List Mode') }
        
        # Limited in what we can test within the google maps with rspec
      
      end
    end
  
  end

end
