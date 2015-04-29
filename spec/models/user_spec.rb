require 'rails_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }

  it { should respond_to(:firstname) }
  it { should respond_to(:surname) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:approved) }
  it { should respond_to(:role) }

  it { should be_valid }

  # Presence checks
  describe "when firstname is not present" do
    before { @user.firstname = " " }
    it { should_not be_valid }
  end
  
  describe "when surname is not present" do
    before { @user.surname = " " }
    it { should_not be_valid }
  end
  
  describe "when full name includes numbers" do
    before { @user.surname = "Smith4" }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  
  #Length checks
  describe "when firstname is too long" do
    before { @user.firstname = "a" * 51 }
    it { should_not be_valid }
  end
 
 describe "when surname is too long" do
    before { @user.surname = "a" * 51 }
    it { should_not be_valid }
  end
  
  
  # email checks
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end 
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end
  
  
  #Password checks
  describe "when password is not present" do
    before do
      @user.password = ''
      @user.password_confirmation = ''
    end
    
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end
  
  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end
  
  
  # role checks
  describe "check that a user role is valid" do
    before {@user.role = 'user'}
    it { should be_valid }
  end
  
  describe "check that a superuser role is valid" do
    before {@user.role = 'superuser'}
    it { should be_valid }
  end
  
  describe "check that an admin role is valid" do
    before {@user.role = 'admin'}
    it { should be_valid }
  end

  describe "check that a random role is not valid" do
    before {@user.role = 'invalid'}
    it { should_not be_valid }
  end
  
  describe "check that an empty role is not valid" do
    before {@user.role = ''}
    it { should_not be_valid }
  end  
    
  # describe "sample_set associations" do
# 
    # before { @user.save }
    # let!(:older_sample_set) {FactoryGirl.create(:sample_set, owner: @user, created_at: 1.day.ago)}
    # let!(:newer_sample_set) {FactoryGirl.create(:sample_set, owner: @user, created_at: 1.hour.ago)}
# 
# 
    # it "should have the right sample_sets in the right order" do
      # expect(@user.sample_sets.to_a).to eq [newer_sample_set, older_sample_set]
    # end
#     
    # describe "status" do
      # let(:unowned_sample_set) do
        # FactoryGirl.create(:sample_set, owner: FactoryGirl.create(:user))
      # end
# 
      # its(:my_sample_sets) { should include(newer_sample_set) }
      # its(:my_sample_sets) { should include(older_sample_set) }
      # its(:my_sample_sets) { should_not include(unowned_sample_set) }
    # end
#     
  # end
  
end
