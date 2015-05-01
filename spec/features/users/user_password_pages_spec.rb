require 'rails_helper'

RSpec.describe "Users", type: :feature do
  
  subject { page }

  
  describe "Reset password page" do
    before { visit new_user_password_path }

    it { should have_title(full_title('Password Reset')) }
    it { should have_content('Forgot your Password?') }
    it { should have_content('Email') }
    it { should have_content('Password') }
    it { should have_button('Send me reset password instructions') }
    it { should_not have_content('Register New Account') }
  end

  
  describe "password reset steps" do
    let(:submit) { "Send me reset password instructions" }
    before { visit new_user_password_path }

    describe "with invalid information" do
      before { click_button submit }
      it { should have_content("Email can't be blank") }
      it { should have_content('Sign In') }
      it { should_not have_content('Sign Out') }
    end


    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) } 
      
      before do
        fill_in "Email",        with: user.email
        click_button submit
      end   
      it { should have_content('You will receive an email with instructions on how to reset your password in a few minutes.') }
      it { should have_content('Sign In') }
      it { should_not have_content('Sign Out') }
    end    
               
  end
end
