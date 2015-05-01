require 'rails_helper'

RSpec.describe "Users", type: :feature do
  
  subject { page }

  
  describe "signin page" do
    before { visit new_user_session_path }

    it { should have_title(full_title('Sign In')) }
    it { should have_content('Sign In') }
    it { should have_content('Email') }
    it { should have_content('Password') }
    it { should have_content('Forgot your Password?') }
    it { should have_content('Register New Account') }
  end

  
  describe "signin steps" do
    let(:submit) { "Sign In" }
    before { visit new_user_session_path }


    describe "with invalid information" do
      before { click_button submit }
      it { should have_content('Invalid email or password') }
      it { should have_content('Sign In') }
      it { should_not have_content('Sign Out') }
    end


    describe "with valid information for unapproved user" do
      let(:unapproved_user) { FactoryGirl.create(:unapproved_user) } 
      
      before do
        fill_in "Email",        with: unapproved_user.email
        fill_in "Password",     with: unapproved_user.password
        click_button submit
      end   
      it { should have_content('This account is currently unapproved') }
      it { should have_content('Sign In') }
      it { should_not have_content('Sign Out') }
    end    
    
    
    describe "with wrong password for approved user" do
      let(:user) { FactoryGirl.create(:user) } 
      
      before do
        fill_in "Email",        with: user.email
        fill_in "Password",     with: 'wrong_password'
        click_button submit
      end   
      it { should have_content('Invalid email or password') }
      it { should have_content('Sign In') }
      it { should_not have_content('Sign Out') }
    end 
    
    
    describe "with valid information for approved user" do
      let(:user) { FactoryGirl.create(:user) } 
      
      before do
        fill_in "Email",        with: user.email
        fill_in "Password",     with: user.password
        click_button submit
      end   
      it { should have_content('Sign Out, ' + user.firstname.capitalize) }
      it { should_not have_content('Sign In') }
    end             
               
               
  end
end
