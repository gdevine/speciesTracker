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
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
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
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
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
      it 'should not have a nav#minibar bar' do
        expect(page).not_to have_selector('nav#minibar')
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
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
  end


  # For adminss
  describe "for admins" do
    before do 
      sign_in(admin) 
    end
    describe "Home page" do
      before { visit root_path }
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
    describe "About page" do
      before { visit about_path }
      it 'should have a nav#minibar bar' do
        expect(page).to have_selector('nav#minibar')
      end
    end
  end
    

  # Sightings dropdown   
  describe "Opening the Analysis Types dropdown" do
  
    describe "when not signed in" do
      before { visit root_path }
      it 'should not be possible' do
        expect(page).not_to have_link('Sightings')
        expect(page).not_to have_link('sightings_index')
      end
    end

    describe "as a signed in user" do
      before do 
        sign_in(user) 
        visit root_path
      end
      
      it "should show a main link for 'Sightings'" do
        expect(page).to have_link('Sightings')
      end
      it "should show a link for 'View All' Sightings" do
        expect(page).to have_link('sightings_index')
      end
      it "should show a link for 'Add New' Sighting" do
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
    end
    
  
  end

#     
  # # Job Request dropdown   
  # describe "Opening the Jobs dropdown" do
#   
    # describe "when not signed in" do
      # before { visit root_path }
      # it 'should not be possible' do
        # expect(page).not_to have_link('Jobs')
        # expect(page).not_to have_link('job_requests_index')
      # end
    # end
# 
    # describe "when signed in as a researcher" do
      # before do 
        # sign_in(researcher) 
        # visit root_path
      # end
#       
      # it "should show a main link for Jobs" do
        # expect(page).to have_link('Jobs')
      # end
      # it "should show a link for 'View All' Job Requests" do
        # expect(page).to have_link('job_requests_index')
      # end
      # it "should show a link for 'Create New' Job Request" do
        # expect(page).to have_link('job_requests_new')
      # end  
#           
      # describe "and clicking the View All link" do
        # before do
          # click_link('job_requests_index')
        # end
#     
        # it "should open up the View All page" do
          # expect(page).to have_content('Jobs')
        # end
      # end
#     
      # describe "and clicking the Create New link with no analysis types in the system" do
        # before do
          # click_link('job_requests_new')
        # end
#     
        # it "should give an warning about no analysis types" do
          # expect(page).to have_content('New Jobs cannot be created until at least one Analysis Type is added to the system. Contact the admin to do this.')
        # end
      # end
#       
      # describe "and clicking the Create New link with analysis types in the system" do
        # before do
          # @at1 = FactoryGirl.create(:analysis_type)
          # click_link('job_requests_new')
        # end
#     
        # it "should open up the Create New page" do
          # expect(page).to have_title('New Job')
          # expect(page).to have_selector('h2', text: "New Job")
        # end
      # end
#     
    # end
#     
    # describe "when signed in as a technician" do
      # before do 
        # sign_in(technician) 
        # visit root_path
      # end
#       
      # it "should show a main link for 'Jobs'" do
        # expect(page).to have_link('Jobs')
      # end
      # it "should show a link for 'View All' Jobs" do
        # expect(page).to have_link('job_requests_index')
      # end
      # it "should not show a link for 'Add New' Job" do
        # expect(page).not_to have_link('job_requests_new')
      # end  
#           
      # describe "and clicking the View All link" do
        # before do
          # click_link('job_requests_index')
        # end
#     
        # it "should open up the View All page" do
          # expect(page).to have_content('Jobs')
        # end
      # end
    # end
#     
    # describe "when signed in as a superuser" do
      # before do 
        # sign_in(superuser) 
        # visit root_path
      # end
#       
      # it "should show a main link for 'Job Requests'" do
        # expect(page).to have_link('Jobs')
      # end
      # it "should show a link for 'View All' Job Requests" do
        # expect(page).to have_link('job_requests_index')
      # end
      # it "should not show a link for 'Add New' Job Request" do
        # expect(page).not_to have_link('job_requests_new')
      # end  
#           
      # describe "and clicking the View All link" do
        # before do
          # click_link('job_requests_index')
        # end
#     
        # it "should open up the View All page" do
          # expect(page).to have_content('Jobs')
        # end
      # end
#       
    # end
#   
#   
  # end    
    
#       
      # describe "and clicking the View Lost Instruments link" do
        # before do
          # click_link('losts_index')
        # end
#     
        # it "should open up the View current losts page" do
          # expect(page).to have_title('Lost List')
        # end
      # end
#       
      # describe "and clicking the View In Storage link" do
        # before do
          # click_link('storages_index')
        # end
#     
        # it "should open up the View current storages page" do
          # expect(page).to have_title('In Storage List')
        # end
      # end
#       
      # describe "and clicking the View Face Deployment link" do
        # before do
          # click_link('facedeployments_index')
        # end
#     
        # it "should open up the View current face deployments page" do
          # expect(page).to have_title('FACE Deployment List')
        # end
      # end
#       
      # describe "and clicking the View Retired link" do
        # before do
          # click_link('retirements_index')
        # end
#     
        # it "should open up the View current retirements page" do
          # expect(page).to have_title('Retired List')
        # end
      # end
#       
      # describe "and clicking the Create New link" do
        # before do
          # FactoryGirl.create(:model)
          # click_link('instruments_new')
        # end
#     
        # it "should open up the Create Instrument page" do
          # expect(page).to have_title('New Instrument')
        # end
      # end
    
#   
# # Resources menu
#   
  # describe "opening the resources dropdown" do
    # before { sign_in(user) }
    # before { visit root_path }
#     
    # describe "and clicking the models link" do
      # before do
        # click_link('Models')
      # end
#   
      # it "should open up the models index page" do
        # expect(page).to have_title('Models List')
      # end
    # end
  # end
  

end
