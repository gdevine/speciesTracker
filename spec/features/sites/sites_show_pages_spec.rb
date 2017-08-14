require 'rails_helper'

RSpec.describe "Site", type: :feature do

  subject { page }

  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }


  describe "Show page" do

    before do
      @site = FactoryGirl.create(:site)
    end

    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit site_path(@site) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end


    describe "for users" do
      describe "should show details of the research site" do
        before do
          sign_in user
          visit site_path(@site)
        end
        it { should have_title('Research Site View') }
        it { should have_selector('h2', text: "Research Site " + @site.id.to_s) }
        it { should_not have_title('| Home') }

        it { should have_content('Name') }
        it { should have_content(@site.name) }

        it { should have_content('Street') }
        it { should have_content(@site.street) }

        it { should have_content('Suburb') }
        it { should have_content(@site.suburb) }

        it { should have_content('Comments') }
        it { should have_content(@site.comments) }

        it { should have_content('Number of Sightings') }
        it { should have_css("p#sightings_count", text: @site.sightings.count)}

        let!(:centrelat) { "%10.6f" % @site.centre_lat }
        let!(:centrelon) { "%10.6f" % @site.centre_lon }
        let!(:centrealt) { "%3.1f" % @site.centre_alt }
        it { should have_content(centrelat)}
        it { should have_content(centrelon)}
        it { should have_content(centrealt)}
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Research Site') }
        it { should_not have_link('Delete Research Site') }
      end
    end


    describe "for superusers" do
      describe "should show details of the research site" do
        before do
          sign_in superuser
          visit site_path(@site)
        end
        it { should have_title('Research Site View') }
        it { should have_selector('h2', text: "Research Site " + @site.id.to_s) }

        it { should have_content('Name') }
        it { should have_content(@site.name) }

        it { should have_content('Street') }
        it { should have_content(@site.street) }

        it { should have_content('Suburb') }
        it { should have_content(@site.suburb) }

        it { should have_content('Comments') }
        it { should have_content(@site.comments) }

        it { should have_content('Number of Sightings') }
        it { should have_css("p#sightings_count", text: @site.sightings.count)}
        let!(:centrelat) { "%10.6f" % @site.centre_lat }
        let!(:centrelon) { "%10.6f" % @site.centre_lon }
        let!(:centrealt) { "%3.1f" % @site.centre_alt }
        it { should have_content(centrelat)}
        it { should have_content(centrelon)}
        it { should have_content(centrealt)}
        it { should have_link('Options') }
        it { should have_link('Edit Research Site') }
        it { should have_link('Delete Research Site') }

        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Research Site' }
          let!(:page_heading) {"Edit Research Site " + @site.id.to_s}

          it { should have_content(page_heading) }
        end

      end

    end


    # This test really doesn't belong here but I'm throwing it in as a secondary check
    describe "for superusers who have been marked unapproved" do
      describe "should be redirected to sign in page with unapproved message" do
        before do
          superuser.approved = false
          superuser.save
          sign_in superuser
        end

        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("This account is currently unapproved") }
      end
    end


    describe "for admins" do
      describe "should show details of the site" do
        before do
          sign_in admin
          visit site_path(@site)
        end
        it { should have_title('Research Site View') }
        it { should have_selector('h2', text: "Research Site " + @site.id.to_s) }
        it { should_not have_title('| Home') }

        it { should have_content('Name') }
        it { should have_content(@site.name) }

        it { should have_content('Street') }
        it { should have_content(@site.street) }

        it { should have_content('Suburb') }
        it { should have_content(@site.suburb) }

        it { should have_content('Comments') }
        it { should have_content(@site.comments) }

        it { should have_content('Number of Sightings') }
        it { should have_css("p#sightings_count", text: @site.sightings.count)}

        let!(:centrelat) { "%10.6f" % @site.centre_lat }
        let!(:centrelon) { "%10.6f" % @site.centre_lon }
        let!(:centrealt) { "%3.1f" % @site.centre_alt }
        it { should have_content(centrelat)}
        it { should have_content(centrelon)}
        it { should have_content(centrealt)}
        it { should have_link('Options') }
        it { should have_link('Edit Research Site') }
        it { should have_link('Delete Research Site') }


        describe "should navigate to correct edit page on following edit link" do
          before { click_link "Edit Research Site" }
          let!(:page_heading) {"Edit Research Site " + @site.id.to_s}

          it { should have_content(page_heading) }
        end

      end

    end

  end

end
