require 'rails_helper'

RSpec.describe "Static Pages", type: :feature do
  
  subject { page }

   
  describe "Home page" do 
    
    describe "when not logged in" do
      before { visit root_path }
      it { should have_title(full_title('Home')) }
      it { should have_content('Sign In') }
      it { should have_content('Register') }
    end
    
    describe "when logged in as user" do
      let(:user) { FactoryGirl.create(:user) }
 
      before do
        sign_in user
        visit root_path
      end
      
      it { should have_content('Sign Out, '+ user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Home')) }
    end

    describe "when logged in as superuser" do
      let(:user) { FactoryGirl.create(:superuser) }
 
      before do
        sign_in user
        visit root_path
      end
      
      it { should have_content('Sign Out, '+ user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Home')) }
    end

    describe "when logged in as admin" do
      let(:user) { FactoryGirl.create(:admin) }
 
      before do
        sign_in user
        visit root_path
      end
      
      it { should have_content('Sign Out, '+ user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Home')) }
    end
    
  end
  
  
  describe "Help page" do
    
    describe "when not logged in" do
      before { visit help_path }
      it { should have_title('Help') }
      it { should have_content('Sign In') }
    end
    
    describe "when logged in as user" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        sign_in user
        visit help_path
      end

      it { should have_content('Sign Out, '+user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Help')) }
    end
  
  end

  
  describe "About page" do
    before { visit about_path }

    it { should have_title(full_title('About')) }
  end
  
  
  describe "Contact page" do
    before { visit contact_path }

    it { should have_title(full_title('Contact')) }
  end
  
  
  describe "Superuser test page" do 
    
    describe "when not logged in" do
      before { visit superuseronlypage_path }
      it { should have_title(full_title('Home')) }
      it { should have_content('Sign In') }
      it { should have_content('Register') }
    end
    
    describe "when logged in as user" do
      let(:user) { FactoryGirl.create(:user) }
 
      before do
        sign_in user
        visit superuseronlypage_path
      end
      
      it { should have_title(full_title('Home')) }
      it { should have_content('You are not authorized to access this page.') }
      it { should_not have_content('Sign In') }
      it { should_not have_content('Register') }
    end

    describe "when logged in as superuser" do
      let(:superuser) { FactoryGirl.create(:superuser) }
 
      before do
        sign_in superuser
        visit superuseronlypage_path
      end
      
      it { should have_content('Sign Out, '+ superuser.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Superuser Only Page')) }
    end

    describe "when logged in as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
 
      before do
        sign_in admin
        visit superuseronlypage_path
      end
      
      it { should have_content('Sign Out, '+ admin.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Superuser Only Page')) }
    end
    
  end
  
  
 describe "Admin test page" do 
    
    describe "when not logged in" do
      before { visit adminonlypage_path }
      it { should have_title(full_title('Home')) }
      it { should have_content('Sign In') }
      it { should have_content('Register') }
    end
    
    describe "when logged in as user" do
      let(:user) { FactoryGirl.create(:user) }
 
      before do
        sign_in user
        visit adminonlypage_path
      end
      
      it { should have_title(full_title('Home')) }
      it { should have_content('You are not authorized to access this page.') }
      it { should_not have_content('Sign In') }
      it { should_not have_content('Register') }
    end

    describe "when logged in as superuser" do
      let(:superuser) { FactoryGirl.create(:superuser) }
 
      before do
        sign_in superuser
        visit adminonlypage_path
      end
      
      it { should have_title(full_title('Home')) }
      it { should have_content('You are not authorized to access this page.') }
      it { should_not have_content('Sign In') }
      it { should_not have_content('Register') }
    end

    describe "when logged in as admin" do
      let(:admin) { FactoryGirl.create(:admin) }
 
      before do
        sign_in admin
        visit adminonlypage_path
      end
      
      it { should have_content('Sign Out, '+ admin.firstname.capitalize) }
      it { should_not have_content('Sign In') }
      it { should have_title(full_title('Admin Only Page')) }
    end
    
    describe "when logged in as an unapproved user" do
      let(:admin) { FactoryGirl.create(:admin) }
 
      before do
        admin.approved = false
        admin.save
        sign_in admin
        visit adminonlypage_path
      end
      
      it { should_not have_content('Sign Out, '+ admin.firstname.capitalize) }
      it { should have_content('Sign In') }
      it { should have_content('You are not authorized to access this page.') }
      it { should_not have_title(full_title('Admin')) }
    end
    
  end  
  
end