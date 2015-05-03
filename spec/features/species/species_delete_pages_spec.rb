require 'rails_helper'

RSpec.describe "Species", type: :feature do
  
  subject { page }
  
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Species Deletion" do
    
    before do 
      @species = FactoryGirl.create(:species)
    end     
    
    describe "for superusers" do
      before do
        sign_in superuser
        visit species_path(@species)
      end
    
      it "should delete" do
        expect { click_link "Delete Species" }.to change(Species, :count).by(-1)
      end
    
      describe "should revert to species list page with success message and updated info" do
        before { click_link "Delete Species" }
        it { should have_content('Species Deleted!') }
        it { should have_content('No Species found') }
        it { should have_title(full_title('Species')) }  
        it { should_not have_link('View', :href => species_path(@species)) }
      end
  
    end
    
    
    describe "for admins" do
      before do
        sign_in admin
        visit species_path(@species)
      end
    
      it "should delete" do
        expect { click_link "Delete Species" }.to change(Species, :count).by(-1)
      end
    
      describe "should revert to species list page with success message and updated info" do
        before { click_link "Delete Species" }
        it { should have_content('Species Deleted!') }
        it { should have_content('No Species found') }
        it { should have_title(full_title('Species')) }  
        it { should_not have_link('View', :href => species_path(@species)) }
      end
  
    end 
  end
  
end