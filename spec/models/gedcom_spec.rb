# == Schema Information
#
# Table name: gedcoms
#
#  id                  :integer         not null, primary key
#  gedcom_file_name    :string(255)
#  gedcom_file_size    :integer
#  gedcom_content_type :string(255)
#  gedcom_updated_at   :datetime
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe Gedcom do

  before(:each) do
    @user = Factory(:user)
    @user.create_gedcom!(:gedcom =>
      Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
  end

  after(:each) do
    @user.destroy
  end

  describe "user associations" do
    
    it "should have a user attribute" do
      @user.gedcom.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @user.gedcom.user_id.should == @user.id
      @user.gedcom.user.should == @user
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
