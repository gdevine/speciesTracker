require 'rails_helper'

RSpec.describe Sighting, type: :model do
  
  before do 
    @sighting = FactoryGirl.create(:sighting) 
  end
  
  subject { @sighting }

  it { should respond_to(:species) }
  it { should respond_to(:species_id) }
  it { should respond_to(:datetime_sighted) }
  it { should respond_to(:site) }
  it { should respond_to(:site_id) }
  it { should respond_to(:comments) }
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
  it { should respond_to(:altitude) }
  it { should respond_to(:spotter) }
  it { should respond_to(:spotter_id) }
  it { should respond_to(:creator) }
  it { should respond_to(:photo) }
  it { should respond_to(:creator_id) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  it { should be_valid }

  
# Presence checks
  describe "when species_id is not present" do
    before { @sighting.species_id = " " }
    it { should_not be_valid }
  end
  
  describe "when creator_id is not present" do
    before { @sighting.creator_id = " " }
    it { should_not be_valid }
  end   
  
  describe "when spotter_id is not present" do
    before { @sighting.spotter_id = " " }
    it { should_not be_valid }
  end   

  describe "when datetime_sighted is not present" do
    before { @sighting.datetime_sighted = " " }
    it { should_not be_valid }
  end      
# 
  # describe "when a photo is not present" do
    # before { @sighting.photo = " " }
    # it { should_not be_valid }
  # end      
  
  # Sensible date sighted
  describe "when datetime_sighted is in the future" do
    before { @sighting.datetime_sighted = Time.now + 2.days }
    it { should_not be_valid }
  end
  
  # Check different combinations of site and specific co-ordinates
  # At minimum a site must be given or specific co-ordinates must be given
  describe "when site id nor co-ords are not present" do
    before do
      @sighting.site_id = " "
      @sighting.latitude = " "
      @sighting.longitude = " "
    end
    it { should_not be_valid }
  end  
  
  describe "when site is empty but co-ordinates are present" do
    before do
      @sighting.site_id = " "
      @sighting.latitude = -34.1
      @sighting.longitude = 153.2
    end
    it { should be_valid }
  end 
  
  describe "when site is given but co-ordinates are empty" do
    before do
      @sighting.latitude = ""
      @sighting.longitude = ""
    end
    it { should be_valid }
  end 
  
  describe "when site is given and one of lat/long is empty" do
    before do
      @sighting.latitude = 35.0
      @sighting.longitude = ""
    end
    it { should_not be_valid }
  end 

  describe "when site is empty and invalid co-ordinates are present" do
    before do
      @sighting.site_id = " "
      @sighting.latitude = -340.1
      @sighting.longitude = 153.2
    end
    it { should_not be_valid }
  end 
  
  describe "when both site and co-ordinates are present" do
    before do
      @sighting.latitude = -34.1
      @sighting.longitude = 153.2
    end
    it { should be_valid }
  end 
  
  #Sensible co-ordinates
  describe "when latitude is too high" do
    before { @sighting.latitude = 100.03 }
    it { should_not be_valid }
  end
  
  describe "when latitude is too low" do
    before { @sighting.latitude = -120.03 }
    it { should_not be_valid }
  end

  describe "when latitude is alphabetic" do
    before { @sighting.latitude = 'aabb' }
    it { should_not be_valid }
  end
  
  describe "when latitude is empty" do
    before do
      @sighting.latitude = '' 
      @sighting.longitude = 131.0 
    end
    it { should_not be_valid }
  end
  
  describe "when longitude is too high" do
    before { @sighting.longitude = 400.03 }
    it { should_not be_valid }
  end
  
  describe "when longitude is too low" do
    before { @sighting.longitude = -12.03 }
    it { should_not be_valid }
  end

  describe "when longitude is alphabetic" do
    before { @sighting.longitude = 'bbaa' }
    it { should_not be_valid }
  end
  
  describe "when longitude is empty" do
    before do 
      @sighting.latitude = 33.9
      @sighting.longitude = ''
    end
    it { should_not be_valid }
  end
  
  describe "when both latitude and longitude are empty" do
    before do
       @sighting.latitude = '' 
       @sighting.longitude = '' 
    end 
    
    it { should be_valid }
  end

  describe "when altitude is too high" do
    before { @sighting.altitude = 11000.00 }
    it { should_not be_valid }
  end
  
  describe "when altitude is too low" do
    before { @sighting.altitude = -12.00 }
    it { should_not be_valid }
  end

  describe "when altitude is alphabetic" do
    before { @sighting.altitude = 'bbaa' }
    it { should_not be_valid }
  end

  describe "when altitude is empty" do
    before { @sighting.altitude = '' }
    it { should be_valid }
  end
  
  
  # Check that associations exist
  describe "when site does not exist" do
    before { @sighting.site_id = 10000 }
    it { should_not be_valid }
  end  
  
  describe "when species does not exist" do
    before { @sighting.species_id = 10000 }
    it { should_not be_valid }
  end  
  
  describe "when creator does not exist" do
    before { @sighting.creator_id = 10000 }
    it { should_not be_valid }
  end  
  
  describe "when spotter does not exist" do
    before { @sighting.spotter_id = 10000 }
    it { should_not be_valid }
  end  


  # Check that circumstances of differing creator spotter only exist when creator is an admin or superuser
  describe "when creator is a normal user" do  
    let!(:user2) {FactoryGirl.create(:user)}
    
    describe "spotter should be the same person" do  
      before do 
        @sighting.creator = user2
      end
      it { should_not be_valid } 
    end    
  end

  describe "when creator is a superuser/admin" do  
    let!(:superuser) {FactoryGirl.create(:superuser)}
    
    describe "spotter can be a different person" do  
      before do 
        @sighting.creator = superuser
      end
      it { should be_valid } 
    end    
  end
      
end
