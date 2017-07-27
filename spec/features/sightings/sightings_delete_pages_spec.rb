require 'rails_helper'

RSpec.describe "Sighting", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }


  describe "Sighting Deletion" do

    before do
      @sighting = FactoryGirl.create(:sighting)
    end

    describe "for users who created the sighting" do
      before do
        @sighting.creator = user
        @sighting.spotter = user
        @sighting.save
        sign_in user
        visit sighting_path(@sighting)
      end

      it "should delete" do
        expect { click_link "Delete Sighting" }.to change(Sighting, :count).by(-1)
      end

      describe "should revert to sighting list page with success message and updated info" do
        before { click_link "Delete Sighting" }
        it { should have_content('Sighting Deleted!') }
        it { should have_content('No Sightings found') }
        it { should have_title(full_title('Sightings')) }
        it { should have_content('Sightings') }
        it { should_not have_link('View', :href => sighting_path(@sighting)) }
      end

    end


    describe "for users who spotted, but didnt create, the sighting" do
      before do
        @sighting.spotter = user
        @sighting.save
        sign_in user
        visit sighting_path(@sighting)
      end

      it "should delete" do
        expect { click_link "Delete Sighting" }.to change(Sighting, :count).by(-1)
      end

      describe "should revert to sighting list page with success message and updated info" do
        before { click_link "Delete Sighting" }
        it { should have_content('Sighting Deleted!') }
        it { should have_content('No Sightings found') }
        it { should have_title(full_title('Sightings')) }
        it { should have_content('Sightings') }
        it { should_not have_link('View', :href => sighting_path(@sighting)) }
      end

    end


    describe "for superusers who created the sighting" do
      before do
        @sighting.creator = superuser
        @sighting.save
        sign_in superuser
        visit sighting_path(@sighting)
      end

      it "should delete" do
        expect { click_link "Delete Sighting" }.to change(Sighting, :count).by(-1)
      end

      describe "should revert to sighting list page with success message and updated info" do
        before { click_link "Delete Sighting" }
        it { should have_content('Sighting Deleted!') }
        it { should have_content('No Sightings found') }
        it { should have_title(full_title('Sightings')) }
        it { should have_content('Sightings') }
        it { should_not have_link('View', :href => sighting_path(@sighting)) }
      end

    end


    describe "for admins" do
      before do
        sign_in admin
        visit sighting_path(@sighting)
      end

      it "should delete" do
        expect { click_link "Delete Sighting" }.to change(Sighting, :count).by(-1)
      end

      describe "should revert to sighting list page with success message and updated info" do
        before { click_link "Delete Sighting" }
        it { should have_content('Sighting Deleted!') }
        it { should have_content('No Sightings found') }
        it { should have_title(full_title('Sightings')) }
        it { should have_content('Sightings') }
        it { should_not have_link('View', :href => sighting_path(@sighting)) }
      end

    end
  end

end
