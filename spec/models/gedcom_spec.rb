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

require 'rails_helper'

describe Gedcom do

  before(:each) do
    @user = FactoryBot.create(:user)
    @attr = {
      :gedcom_file_name => Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED")
    }
    # @user.create_gedcom!(:gedcom =>
    #   Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
  end

  # after(:each) do
  #   @gedcom.destroy
  # end

  describe "user associations" do
    
    before(:each) do
      @gedcom = Gedcom.new(@attr)
      @gedcom.user=(@user)
      # puts @gedcom.inspect
    end

    it "should have a user attribute" do
      expect(@gedcom).to respond_to(:user)
    end
    
    it "should have the right associated user" do
      expect(@gedcom.user_id).to eq(@user.id)
      expect(@gedcom.user).to eq(@user)
    end
  end

  # pending "add some examples to (or delete) #{__FILE__}"
end
