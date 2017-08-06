require 'rails_helper'

RSpec.describe "Sighting", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }


  describe "Index page" do

    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit sightings_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end

    describe "for users" do
      before { sign_in user }

      describe "with no sightings in the system" do
        before { visit sightings_path }

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

      describe "with sighting in the system" do
        before do
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit sightings_path
        end

        it { should have_content('Site') }
        it { should have_content('Species') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
        it { should have_content(@s1.site.name) }
        it { should have_content(@s2.site.name) }
        it { should have_content(@s3.site.name) }
        it { should have_content(@s1.species.fullname) }
        it { should have_content(@s2.species.fullname) }
        it { should have_content(@s3.species.fullname) }

        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{sighting_path(@s1)}']", :visible => false).click }
          it { should have_selector('h2', text: "Sighting " + @s1.id.to_s) }
        end

      end
    end


    describe "for superusers" do
      before { sign_in superuser }

     describe "with no sightings in the system" do
        before { visit sightings_path }

        it { should have_title('Sightings') }
        it { should_not have_title('| Home') }
        it { should have_selector('h2', text: "Sightings") }
        it "should have an information message" do
          expect(page).to have_content('No Sightings found')
        end
      end

      describe "with sighting in the system" do
        before do
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit sightings_path
        end

        it { should have_content('Site') }
        it { should have_content('Species') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
        it { should have_content(@s1.site.name) }
        it { should have_content(@s2.site.name) }
        it { should have_content(@s3.site.name) }
        it { should have_content(@s1.species.fullname) }
        it { should have_content(@s2.species.fullname) }
        it { should have_content(@s3.species.fullname) }

        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{sighting_path(@s1)}']", :visible => false).click }
          it { should have_selector('h2', text: "Sighting " + @s1.id.to_s) }
        end

      end

    end


    describe "for admins" do
      before { sign_in admin }

      describe "with no sightings in the system" do
        before { visit sightings_path }

        it { should have_title('Sightings') }
        it { should_not have_title('| Home') }
        it { should have_selector('h2', text: "Sightings") }
        it "should have an information message" do
          expect(page).to have_content('No Sightings found')
        end
      end

      describe "with sighting in the system" do
        before do
          @s1 = FactoryGirl.create(:sighting)
          @s2 = FactoryGirl.create(:sighting)
          @s3 = FactoryGirl.create(:sighting)
          visit sightings_path
        end

        it { should have_content('Site') }
        it { should have_content('Species') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_link('View Map Mode') }
        it { should_not have_link('View List Mode') }
        it { should have_content(@s1.site.name) }
        it { should have_content(@s2.site.name) }
        it { should have_content(@s3.site.name) }
        it { should have_content(@s1.species.fullname) }
        it { should have_content(@s2.species.fullname) }
        it { should have_content(@s3.species.fullname) }

        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{sighting_path(@s1)}']", :visible => false).click }
          it { should have_selector('h2', text: "Sighting " + @s1.id.to_s) }
        end

      end

    end

  end


end
