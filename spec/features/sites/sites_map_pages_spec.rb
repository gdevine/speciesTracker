require 'rails_helper'

RSpec.describe "Site", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }


  describe "Index Map page" do

    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit map_sites_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end

    describe "for users" do
      before { sign_in user }

      describe "with no sites in the system" do
        before { visit map_sites_path }

        it { should have_title('Sites') }
        it { should_not have_title('| Home') }
        it { should have_selector('h2', text: "Research Sites") }
        it "should have an information message" do
          expect(page).to have_content('No Research Sites found')
        end
        #With no sites neither toggle button should show
        it { should_not have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
      end

      describe "with site in the system" do
        before do
          @s1 = FactoryGirl.create(:site)
          @s2 = FactoryGirl.create(:site)
          @s3 = FactoryGirl.create(:site)
          visit map_sites_path
        end

        it { should have_selector('div#map')}

      end
    end


    describe "for superusers" do
      before { sign_in superuser }

      describe "with no sites in the system" do
        before { visit map_sites_path }

        it { should have_title('Sites') }
        it { should_not have_title('| Home') }
        it { should have_selector('h2', text: "Research Sites") }
        it "should have an information message" do
          expect(page).to have_content('No Research Sites found')
        end
        #With no sites neither toggle button should show
        it { should_not have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
      end

      describe "with site in the system" do
        before do
          @s1 = FactoryGirl.create(:site)
          @s2 = FactoryGirl.create(:site)
          @s3 = FactoryGirl.create(:site)
          visit map_sites_path
        end

        it { should have_selector('div#map')}

        # Limited in what we can test within the google maps with rspec

      end
    end

  end

end
