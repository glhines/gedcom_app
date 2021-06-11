require 'rails_helper'

describe GedcomsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      expect(response).to redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :params => { :id => 1 }
      expect(response).to redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    describe "success" do

      before(:each) do
        @user = test_sign_in(FactoryBot.create(:user))
      end

      after(:each) do
        @user.destroy
      end

      it "should create a gedcom" do
        expect do
          # post :create, @attr
          @user.create_gedcom!(:gedcom =>
            Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
        end.to change(Gedcom, :count).by(1)

      end

    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = FactoryBot.create(:user)
        wrong_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))
        test_sign_in(wrong_user)
        @user.create_gedcom!(:gedcom =>
          Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
      end

      it "should deny access" do
        delete :destroy, :params => { :id => @user.gedcom }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @user.create_gedcom!(:gedcom =>
          Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
      end

      after(:each) do
        @user.destroy
      end

      it "should destroy the gedcom" do
        lambda do 
          delete :destroy, :id => @user.gedcom
        end.should change(Gedcom, :count).by(-1)
      end
    end
  end

  describe "SHOW" do

    before(:each) do
      @user = Factory(:user)
      @user = test_sign_in(@user)
      @user.create_gedcom!(:gedcom =>
        Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
    end

    after(:each) do
      @user.destroy
    end

    it "should display the gedcom" do
      get :show, :id => @user.gedcom
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @user.gedcom
      response.should have_selector("title", 
                                    :content => @user.gedcom.gedcom_file_name)
    end
 
    it "should provide a Birthplaces Report link" do
      get :show, :id => @user.gedcom
      response.should have_selector("a", 
                               :href => birthplaces_gedcom_path(@user.gedcom),
                               :content => "Birthplaces Report")
    end
 
    it "should provide link to delete the gedcom" do
      get :show, :id => @user.gedcom
      response.should have_selector("a", 
                               :href => gedcom_path(@user.gedcom),
                               :content => "Delete GEDCOM")
    end
  end

  describe "SHOW Birthplaces Report" do

    before(:each) do
      @user = Factory(:user)
      @user = test_sign_in(@user)
      @user.create_gedcom!(:gedcom =>
        Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
    end

    after(:each) do
      @user.destroy
    end

    it "should display the birthplaces report" do
      get :birthplaces, :id => @user.gedcom
      response.should be_success
    end

    it "should have the right title" do
      get :birthplaces, :id => @user.gedcom
      response.should have_selector("title", 
                                    :content => "Birthplaces")
    end
 
    it "should provide a rollup report link" do
      get :birthplaces, :id => @user.gedcom
      response.should have_selector("a", 
                               :href => rollup_gedcom_path(@user.gedcom),
                               :content => "Birthplaces Rollup Report")
    end
 
  end

  describe "SHOW Birthplaces Rollup Report" do

    before(:each) do
      @user = Factory(:user)
      @user = test_sign_in(@user)
      @user.create_gedcom!(:gedcom =>
        Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
    end

    after(:each) do
      @user.destroy
    end

    it "should display the birthplaces rollup report" do
      get :rollup, :id => @user.gedcom
      response.should be_success
    end

    it "should provide a full birthplaces report link" do
      get :rollup, :id => @user.gedcom
      response.should have_selector("a", 
                               :href => birthplaces_gedcom_path(@user.gedcom),
                               :content => "Birthplaces Report")
    end
 
  end

end
