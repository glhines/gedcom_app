require 'rails_helper'

describe Micropost do

  before(:each) do
    @user = FactoryBot.create(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do
    
    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      # @micropost.should respond_to(:user)
      expect(@micropost).to respond_to(:user)
    end
    
    it "should have the right associated user" do
      # @micropost.user_id.should == @user.id
      # @micropost.user.should == @user
      expect(@micropost.user_id).to eq(@user.id)
      expect(@micropost.user).to eq(@user)
    end
  end

  describe "validations" do

    it "should require a user id" do
      expect(Micropost.new(@attr)).to_not be_valid
    end

    it "should require nonblank content" do
      expect(@user.microposts.build(:content => "  ")).to_not be_valid
    end

    it "should reject long content" do
      expect(@user.microposts.build(:content => "a" * 141)).to_not be_valid
    end
  end

  describe "from_users_followed_by" do

    before(:each) do
      @other_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))
      @third_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))

      @user_post  = @user.microposts.create!(:content => "foo")
      @other_post = @other_user.microposts.create!(:content => "bar")
      @third_post = @third_user.microposts.create!(:content => "baz")

      @user.follow!(@other_user)
    end

    it "should have a from_users_followed_by class method" do
      expect(Micropost).to respond_to(:from_users_followed_by)
    end

    it "should include the followed user's microposts" do
      expect(Micropost.from_users_followed_by(@user)).to include(@other_post)
    end

    it "should include the user's own microposts" do
      expect(Micropost.from_users_followed_by(@user)).to include(@user_post)
    end

    it "should not include an unfollowed user's microposts" do
      expect(Micropost.from_users_followed_by(@user)).to_not include(@third_post)
    end
  end
  
end
