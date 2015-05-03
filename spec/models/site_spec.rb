require 'rails_helper'

RSpec.describe Site, type: :model do

   before do 
    @site = FactoryGirl.build(:site) 
  end
  
  subject { @site }

  it { should respond_to(:name) }
  it { should respond_to(:street) }
  it { should respond_to(:suburb) }
  it { should respond_to(:comments) }
  it { should respond_to(:centre_lat) }
  it { should respond_to(:centre_lon) }
  it { should respond_to(:centre_alt) }

  it { should be_valid }
  
  # Presence checks
  describe "when name is not present" do
    before { @site.name = " " }
    it { should_not be_valid }
  end
  
  describe "when suburb is not present" do
    before { @site.suburb = " " }
    it { should_not be_valid }
  end
  
  describe "when latitude is not present" do
    before { @site.centre_lat = " " }
    it { should_not be_valid }
  end
  
  describe "when longitude is not present" do
    before { @site.centre_lon = " " }
    it { should_not be_valid }
  end
  
  describe "when altitude is not present" do
    before { @site.centre_alt = " " }
    it { should_not be_valid }
  end
  
  #Length checks
  describe "when name is too long" do
    before { @site.name = "a" * 81 }
    it { should_not be_valid }
  end
  
  describe "when street is too long" do
    before { @site.street = "a" * 81 }
    it { should_not be_valid }
  end

  describe "when suburb is too long" do
    before { @site.suburb = "a" * 81 }
    it { should_not be_valid }
  end
    
  #Uniqueness checks
  describe "when name is not unique" do    
    before do
      site_same_name = @site.dup
      site_same_name.save
    end
    
    it { should_not be_valid } 
  end
  
end
