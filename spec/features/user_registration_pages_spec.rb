require 'rails_helper'

RSpec.describe "Users", type: :feature do
  
  subject { page }
  
  describe "registration page" do
    before { visit new_user_registration_path }

    it { should have_title(full_title('Registration')) }
    it { should have_content('Sign In') }
    it { should have_content('New User Registration') }
    it { should have_content('First Name') }
    it { should have_content('Surname') }
    it { should have_content('Email') }
    it { should have_content('Password') }
    it { should have_content('Confirm Password') }
  end
  
  describe "registration steps" do
    let(:submit) { "Create my account" }

    before { visit new_user_registration_path }

    describe "with no information filled in" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with invalid email information filled in" do
      before do
        fill_in "First Name",    with: "Example"
        fill_in "Surname",      with: "Bla"
        fill_in "Email",        with: ""
        fill_in "Password",     with: "foobarbar"
        fill_in "Confirm Password", with: "foobarbar"
      end
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "First Name",    with: "Example"
        fill_in "Surname",      with: "Bla"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobarbar"
        fill_in "Confirm Password", with: "foobarbar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the (as yet unapproved) user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
               
        it { should have_link('Sign In') }  # As the account has not been approved yet therefore unable to log in
        it { should have_content('Base App 3') }
        it { should have_selector('div.alert.alert-notice', text: 'You have signed up successfully but your account has not been approved by your administrator yet') }
      end      
    end        
               
  end
end
