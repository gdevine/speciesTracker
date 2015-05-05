require 'rails_helper'

RSpec.describe "Site", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
 
  describe "Site Deletion" do
    
    before do 
      @site = FactoryGirl.create(:site)
    end     
    
    describe "for superusers" do
      before do
        sign_in superuser
        visit site_path(@site)
      end
    
      it "should delete" do
        expect { click_link "Delete Site" }.to change(Site, :count).by(-1)
      end
    
      describe "should revert to site list page with success message and updated info" do
        before { click_link "Delete Site" }
        it { should have_content('Site Deleted!') }
        it { should have_content('No Sites found') }
        it { should have_title(full_title('Sites')) }  
        it { should have_content('Available Sites') }  
        it { should_not have_link('View', :href => site_path(@site)) }
      end
  
    end
    
    
    describe "for admins" do
      before do
        sign_in admin
        visit site_path(@site)
      end
    
      it "should delete" do
        expect { click_link "Delete Site" }.to change(Site, :count).by(-1)
      end
    
      describe "should revert to site list page with success message and updated info" do
        before { click_link "Delete Site" }
        it { should have_content('Site Deleted!') }
        it { should have_content('No Sites found') }
        it { should have_title(full_title('Sites')) }  
        it { should have_content('Available Sites') }  
        it { should_not have_link('View', :href => site_path(@site)) }
      end
  
    end 
  end
  
end
