require 'rails_helper'

RSpec.describe "Species", type: :feature do
  
  subject { page }
  
  let(:user)      { FactoryGirl.create(:user) }
  let(:superuser) { FactoryGirl.create(:superuser) }
  let(:admin)     { FactoryGirl.create(:admin) }
  
  
  describe "Index page" do
    
    describe "for non signed-in users" do
      describe "should be redirected to home page with access error message" do
        before { visit species_index_path }
        it { should have_title('Species Tracker | Sign In') }
        it { should have_content("You need to sign in or sign up before continuing.") }
      end
    end
    
    describe "for users" do
      before { sign_in user }
      
      describe "with no species in the system" do
        before { visit species_index_path }
        
        it { should have_title('Species') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Species") }
        it "should have an information message" do
          expect(page).to have_content('No Species found')
        end
      end
    
      describe "with species in the system" do
        before do 
          @sp1 = FactoryGirl.create(:species)
          @sp2 = FactoryGirl.create(:species)
          @sp3 = FactoryGirl.create(:species)
          visit species_index_path
        end
        
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content(@sp1.genus) }
        it { should have_content(@sp2.genus) }
        it { should have_content(@sp3.genus) }
        it { should have_link('View', :href => species_path(@sp1)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{species_path(@sp1)}']").click }
          it { should have_selector('h2', text: "Species " + @sp1.id.to_s) }  
        end
      
      end
    end
    
    
    describe "for superusers" do
      before { sign_in superuser }
      
      describe "with no species in the system" do
        before { visit species_index_path }
        
        it { should have_title('Species') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Species") }
        it "should have an information message" do
          expect(page).to have_content('No Species found')
        end
      end
    
      describe "with species in the system" do
        before do 
          @sp1 = FactoryGirl.create(:species)
          @sp2 = FactoryGirl.create(:species)
          @sp3 = FactoryGirl.create(:species)
          visit species_index_path
        end
        
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content(@sp1.genus) }
        it { should have_content(@sp2.genus) }
        it { should have_content(@sp3.genus) }
        it { should have_link('View', :href => species_path(@sp1)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{species_path(@sp1)}']").click }
          it { should have_selector('h2', text: "Species " + @sp1.id.to_s) }  
        end
      
      end
    end
 
 
    describe "for admins" do
      before { sign_in admin }
      
      describe "with no species in the system" do
        before { visit species_index_path }
        
        it { should have_title('Species') }
        it { should_not have_title('| Home') }  
        it { should have_selector('h2', text: "Available Species") }
        it "should have an information message" do
          expect(page).to have_content('No Species found')
        end
      end
    
      describe "with species in the system" do
        before do 
          @sp1 = FactoryGirl.create(:species)
          @sp2 = FactoryGirl.create(:species)
          @sp3 = FactoryGirl.create(:species)
          visit species_index_path
        end
        
        it { should have_content('Genus') }
        it { should have_content('Species') }
        it { should have_content('Common Name') }
        it { should have_content(@sp1.genus) }
        it { should have_content(@sp2.genus) }
        it { should have_content(@sp3.genus) }
        it { should have_link('View', :href => species_path(@sp1)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        it { should have_link('View', :href => species_path(@sp3)) }
        
        describe "should navigate to correct page on following view link" do
          before { find("a[href='#{species_path(@sp1)}']").click }
          it { should have_selector('h2', text: "Species " + @sp1.id.to_s) }  
        end
      
      end
    end   
   
  end


end
