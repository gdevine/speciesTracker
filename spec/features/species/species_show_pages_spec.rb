require 'rails_helper'

RSpec.describe "Species", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Show page" do
           
    before do 
      @species = FactoryGirl.create(:species)
    end
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit species_path(@species) }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end


    describe "for users" do
      describe "should show details of the species" do
        before do 
          sign_in user
          visit species_path(@species)
        end
        it { should have_title('Species View') }
        it { should have_selector('h2', text: "Species " + @species.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
        it { should have_content(@species.genus) }
        it { should have_content(@species.species) }
        it { should_not have_link('Options') }
        it { should_not have_link('Edit Species') }
        it { should_not have_link('Delete Species') }
      end
    end

    
    describe "for superusers" do
      describe "should show details of the species" do
        before do 
          sign_in superuser
          visit species_path(@species)
        end
        it { should have_title('Species View') }
        it { should have_selector('h2', text: "Species " + @species.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
        it { should have_content(@species.genus) }
        it { should have_content(@species.species) }
        it { should have_link('Options') }
        it { should have_link('Edit Species') }
        it { should have_link('Delete Species') }
      
        describe "should navigate to correct edit page on following edit link" do
          before { click_link 'Edit Species' }
          let!(:page_heading) {"Edit Species " + @species.id.to_s}
          
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
      describe "should show details of the species" do
        before do 
          sign_in admin
          visit species_path(@species)
        end
        it { should have_title('Species View') }
        it { should have_selector('h2', text: "Species " + @species.id.to_s) }
        it { should_not have_title('| Home') }  
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content('Description') }
        it { should have_content(@species.genus) }
        it { should have_content(@species.species) }
        it { should have_link('Options') }
        it { should have_link('Edit Species') }
        it { should have_link('Delete Species') }

      
        describe "should navigate to correct edit page on following edit link" do
          before { click_link "Edit Species" }
          let!(:page_heading) {"Edit Species " + @species.id.to_s}
          
          it { should have_content(page_heading) }
        end
        
      end
    
    end
    
  end
  
end
