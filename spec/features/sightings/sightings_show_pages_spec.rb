require 'rails_helper'

RSpec.describe "Sighting", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }


  describe "Show page" do

    before do
      @sighting = FactoryGirl.create(:sighting)
    end

    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit sighting_path(@sighting) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
        it { should_not have_selector('div#map')}
      end
    end


    describe "for users who didn't create or sight the sighting" do
      describe "should show details of the sighting" do
        before do
          sign_in user
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should_not have_title('| Home') }
        it { should have_content('Species') }
        it { should have_content('Research Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Sighted by') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Comments') }
        it { should have_content(@sighting.species.fullname) }
        it { should have_content(@sighting.site.name) }
        let!(:latitude) { "%10.6f" % @sighting.latitude }
        let!(:longitude) { "%10.6f" % @sighting.longitude }
        let!(:altitude) { "%4.1f" % @sighting.altitude }
        it { should have_content(latitude)}
        it { should have_content(longitude)}
        it { should have_content(altitude)}
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Sighting') }
        it { should_not have_link('Delete Sighting') }
        it { should have_selector('div#map')}
      end
    end

    describe "for users who created/sighted the sighting" do
      describe "should show details of the sighting" do
        before do
          @sighting.creator = user
          @sighting.spotter = user
          @sighting.save
          sign_in user
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should_not have_title('| Home') }
        it { should have_content('Species') }
        it { should have_content('Research Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Sighted by') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Comments') }
        it { should have_content(@sighting.species.fullname) }
        it { should have_content(@sighting.site.name) }
        let!(:latitude) { "%10.6f" % @sighting.latitude }
        let!(:longitude) { "%10.6f" % @sighting.longitude }
        let!(:altitude) { "%4.1f" % @sighting.altitude }
        it { should have_content(latitude)}
        it { should have_content(longitude)}
        it { should have_content(altitude)}
        it { should have_link('Options') }
        it { should have_link('Edit Sighting') }
        it { should have_link('Delete Sighting') }
        it { should have_selector('div#map')}

        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Sighting' }
          let!(:page_heading) {"Edit Sighting " + @sighting.id.to_s}

          it { should have_content(page_heading) }
        end

      end
    end


    describe "for users who sighted but didn't create the sighting" do
      describe "should show details of the sighting" do
        before do
          @sighting.spotter = user
          @sighting.save
          sign_in user
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should have_link('Options') }
        it { should have_link('Edit Sighting') }
        it { should have_link('Delete Sighting') }
        it { should have_selector('div#map')}

        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Sighting' }
          let!(:page_heading) {"Edit Sighting " + @sighting.id.to_s}

          it { should have_content(page_heading) }
        end

      end
    end


   describe "for superusers who didn't create/sight the sighting" do
      describe "should show details of the sighting" do
        before do
          sign_in superuser
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should_not have_title('| Home') }
        it { should have_content('Species') }
        it { should have_content('Research Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Sighted by') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Comments') }
        it { should have_content(@sighting.species.fullname) }
        it { should have_content(@sighting.site.name) }
        let!(:latitude) { "%10.6f" % @sighting.latitude }
        let!(:longitude) { "%10.6f" % @sighting.longitude }
        let!(:altitude) { "%4.1f" % @sighting.altitude }
        it { should have_content(latitude)}
        it { should have_content(longitude)}
        it { should have_content(altitude)}
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Sighting') }
        it { should_not have_link('Delete Sighting') }
        it { should have_selector('div#map')}

      end
    end


    describe "for superusers who created but didn't sight the sighting" do
      describe "should show details of the sighting" do
        before do
          @sighting.creator = superuser
          @sighting.save
          sign_in superuser
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should_not have_title('| Home') }
        it { should have_content('Species') }
        it { should have_content('Research Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Sighted by') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Comments') }
        it { should have_content(@sighting.species.fullname) }
        it { should have_content(@sighting.site.name) }
        let!(:latitude) { "%10.6f" % @sighting.latitude }
        let!(:longitude) { "%10.6f" % @sighting.longitude }
        let!(:altitude) { "%4.1f" % @sighting.altitude }
        it { should have_content(latitude)}
        it { should have_content(longitude)}
        it { should have_content(altitude)}
        it { should have_link('Options') }
        it { should have_link('Edit Sighting') }
        it { should have_link('Delete Sighting') }
        it { should have_selector('div#map')}

        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Sighting' }
          let!(:page_heading) {"Edit Sighting " + @sighting.id.to_s}

          it { should have_content(page_heading) }
        end

      end
    end


    describe "for admins" do
      describe "should show details of the sighting" do
        before do
          sign_in admin
          visit sighting_path(@sighting)
        end
        it { should have_title('Sighting View') }
        it { should have_selector('h2', text: "Sighting " + @sighting.id.to_s) }
        it { should_not have_title('| Home') }
        it { should have_content('Species') }
        it { should have_content('Research Site') }
        it { should have_content('Date/Time of Sighting') }
        it { should have_content('Sighted by') }
        it { should have_content('Latitude') }
        it { should have_content('Longitude') }
        it { should have_content('Altitude') }
        it { should have_content('Comments') }
        it { should have_content(@sighting.species.fullname) }
        it { should have_content(@sighting.site.name) }
        let!(:latitude) { "%10.6f" % @sighting.latitude }
        let!(:longitude) { "%10.6f" % @sighting.longitude }
        let!(:altitude) { "%4.1f" % @sighting.altitude }
        it { should have_content(latitude)}
        it { should have_content(longitude)}
        it { should have_content(altitude)}
        it { should have_link('Options') }
        it { should have_link('Edit Sighting') }
        it { should have_link('Delete Sighting') }

        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Sighting' }
          let!(:page_heading) {"Edit Sighting " + @sighting.id.to_s}

          it { should have_content(page_heading) }
        end

      end
    end


  end

end
