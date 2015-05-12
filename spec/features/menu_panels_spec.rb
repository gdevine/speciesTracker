require 'rails_helper'

RSpec.describe "Menu Panel - ", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }  

  
  # For non-signed in guests
  describe "for non signed-in users" do
    describe "Home page" do
      before { visit root_path }
      it 'should not have a menu button' do
        expect(page).not_to have_button('Menu')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should not have a menu button' do
        expect(page).not_to have_button('Menu')
      end
    end
  end


  # For users
  describe "for signed-in users" do
    before do 
      sign_in(user) 
    end
    describe "Home page" do
      before { visit root_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
  end
  
  
  # For users who have been marked unapproved
  describe "for non-approved users" do
    before do 
      user.approved = false
      user.save
      sign_in(user) 
    end
    describe "Home page" do
      before { visit root_path }
      it 'should not have a menu button' do
        expect(page).not_to have_button('Menu')
      end
    end
  end
  
  
  # For superusers
  describe "for superusers" do
    before do 
      sign_in(superuser) 
    end
    describe "Home page" do
      before { visit root_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
  end


  # For admins
  describe "for admins" do
    before do 
      sign_in(admin) 
    end
    describe "Home page" do
      before { visit root_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a menu button' do
        expect(page).to have_button('Menu')
      end
    end
  end
    

  # Sightings dropdown   
  describe "Opening the Menu button" do
  
    describe "when not signed in" do
      before { visit root_path }
      it 'should not be possible' do
        expect(page).not_to have_link('View Sightings')
        expect(page).not_to have_link('sightings_index')
      end
    end

    describe "as a signed in user" do
      before do 
        sign_in(user) 
        visit root_path
      end
      
      it "should show a link for 'Sightings'" do
        expect(page).to have_content('View Sightings')
        expect(page).to have_link('sightings_index')
      end
      it "should show a link for 'Create New Sighting'" do
        expect(page).to have_content('Create New Sighting')
        expect(page).to have_link('sightings_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sightings_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sightings')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('sightings_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Sighting')
        end
      end
      
    end
    
    describe "as a superuser" do
      before do 
        sign_in(superuser) 
        visit root_path
      end
      
      it "should show a link for 'Sightings'" do
        expect(page).to have_content('View Sightings')
        expect(page).to have_link('sightings_index')
      end
      it "should show a link for 'Create New Sighting'" do
        expect(page).to have_content('Create New Sighting')
        expect(page).to have_link('sightings_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sightings_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sightings')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('sightings_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Sighting')
        end
      end
      
    end
    
    describe "as an admin" do
      before do 
        sign_in(admin) 
        visit root_path
      end
      
      it "should show a link for 'Sightings'" do
        expect(page).to have_content('View Sightings')
        expect(page).to have_link('sightings_index')
      end
      it "should show a link for 'Create New Sighting'" do
        expect(page).to have_content('Create New Sighting')
        expect(page).to have_link('sightings_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sightings_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sightings')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('sightings_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Sighting')
        end
      end
      
    end
    
  end
  

  # Sites dropdown   
  describe "Opening the Menu button" do
  
    describe "when not signed in" do
      before { visit root_path }
      it 'should not be possible' do
        expect(page).not_to have_link('View Sites')
        expect(page).not_to have_link('sites_index')
      end
    end

    describe "as a signed in user" do
      before do 
        sign_in(user) 
        visit root_path
      end
      
      it "should show a link for 'Sites'" do
        expect(page).to have_content('View Sites')
        expect(page).to have_link('sites_index')
      end
      it "should show a link for 'Create New Site'" do
        expect(page).not_to have_content('Create New Site')
        expect(page).not_to have_link('sites_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sites_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sites')
        end
      end
     
    end
    
    describe "as a superuser" do
      before do 
        sign_in(superuser) 
        visit root_path
      end
      
      it "should show a link for 'Sites'" do
        expect(page).to have_content('View Sites')
        expect(page).to have_link('sites_index')
      end
      it "should show a link for 'Create New Site'" do
        expect(page).to have_content('Create New Site')
        expect(page).to have_link('sites_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sites_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sites')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('sites_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Site')
        end
      end
      
    end
    
    describe "as an admin" do
      before do 
        sign_in(admin) 
        visit root_path
      end
      
      it "should show a link for 'Sites'" do
        expect(page).to have_content('View Sites')
        expect(page).to have_link('sites_index')
      end
      it "should show a link for 'Create New Site'" do
        expect(page).to have_content('Create New Site')
        expect(page).to have_link('sites_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('sites_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Sites')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('sites_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Site')
        end
      end
      
    end
    
  end


  # Species dropdown   
  describe "Opening the menu button" do
  
    describe "when not signed in" do
      before { visit root_path }
      it 'should not be possible' do
        expect(page).not_to have_link('View Species')
        expect(page).not_to have_link('species_index')
      end
    end

    describe "as a signed in user" do
      before do 
        sign_in(user) 
        visit root_path
      end
      
      it "should show a link for 'Species'" do
        expect(page).to have_content('View Species')
        expect(page).to have_link('species_index')
      end
      it "should not show a link for 'Create New Species'" do
        expect(page).to_not have_content('Create New Species')
        expect(page).to_not have_link('species_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('species_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Available Species')
        end
      end
      
    end
    
    describe "as a superuser" do
      before do 
        sign_in(superuser) 
        visit root_path
      end
      
      it "should show a link for 'Species'" do
        expect(page).to have_content('View Species')
        expect(page).to have_link('species_index')
      end
      it "should show a link for 'Create New Species'" do
        expect(page).to have_content('Create New Species')
        expect(page).to have_link('species_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('species_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Available Species')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('species_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Species')
        end
      end
      
    end
    
    describe "as an admin" do
      before do 
        sign_in(admin) 
        visit root_path
      end
      
      it "should show a link for 'Species'" do
        expect(page).to have_content('View Species')
        expect(page).to have_link('species_index')
      end
      it "should show a link for 'Create New Sighting'" do
        expect(page).to have_content('Create New Sighting')
        expect(page).to have_link('species_new')
      end  
          
      describe "and clicking the View All link" do
        before do
          click_link('species_index')
        end
    
        it "should open up the View All page" do
          expect(page).to have_content('Species')
        end
      end
      
      describe "and clicking the Create New link" do
        before do
          click_link('species_new')
        end
    
        it "should open up the New page" do
          expect(page).to have_content('Create New Sighting')
        end
      end
      
    end
    
    
  end

end
