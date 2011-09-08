require 'spec_helper'

describe "Gedcoms" do

  before(:each) do
    @user = Factory(:user)
    visit signin_path
    fill_in :email,    :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end

  after(:each) do
    @user.destroy
  end

  describe "creation" do

    it "should add a new gedcom" do
      lambda do
        visit user_path(@user)
        @user.create_gedcom!(:gedcom =>
          Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
      end.should change(Gedcom, :count).by(1)
    end
  
  end

  describe "birthplaces" do

    before(:each) do
      @user.create_gedcom!(:gedcom =>
        Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
    end

    it "should display a birthplaces report" do
      visit gedcom_path(@user.gedcom)
      click_link "Birthplaces Report"
      response.should have_selector('title', :content => "Birthplaces")
      response.should have_selector('h1', 
        :content => "#{@user.gedcom.gedcom_file_name} Birthplaces")
    end
  
  end

  describe "deletion" do

    before(:each) do
      @user.create_gedcom!(:gedcom =>
        Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
    end

    it "should delete the gedcom" do
      lambda do
        visit gedcom_path(@user.gedcom)
        click_link "Delete GEDCOM"
      end.should change(Gedcom, :count).by(0)
    end
  
  end
  
end
