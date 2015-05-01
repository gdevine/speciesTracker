require 'rails_helper'

RSpec.describe Species, type: :model do

   before do 
    @species = FactoryGirl.build(:species) 
  end
  
  subject { @species }

  it { should respond_to(:genus) }
  it { should respond_to(:species) }
  it { should respond_to(:common_name) }
  it { should respond_to(:description) }

  it { should be_valid }
  
  # Presence checks
  describe "when genus is not present" do
    before { @species.genus = " " }
    it { should_not be_valid }
  end
  
  describe "when species is not present" do
    before { @species.species = " " }
    it { should_not be_valid }
  end
  
  #Length checks
  describe "when genus is too long" do
    before { @species.genus = "a" * 81 }
    it { should_not be_valid }
  end
  
  describe "when species is too long" do
    before { @species.species = "a" * 81 }
    it { should_not be_valid }
  end
  
  #Uniqueness checks
  describe "when genus/species combination is not unique" do    
    before do
      species_same_gs = @species.dup
      species_same_gs.save
    end
    
    it { should_not be_valid } 
  end
  
end
