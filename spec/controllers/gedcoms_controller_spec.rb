require 'spec_helper'

describe GedcomsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @user = Factory(:user)
        @user = test_sign_in(@user)
        @attr = { :gedcom => nil }
      end

      after(:each) do
        @user.destroy
      end
      
      it "should not create a GEDCOM" do
        lambda do
          post :create, :gedcom => @attr
        end.should_not change(Gedcom, :count)
      end

      it "should render the home page" do
        post :create, :gedcom => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @user = Factory(:user)
        @user = test_sign_in(@user)
      end

      after(:each) do
        @user.destroy
      end

      it "should create a gedcom" do
        lambda do
          # post :create, @attr
          @user.create_gedcom!(:gedcom =>
            Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
        end.should change(Gedcom, :count).by(1)
      end

    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @user.create_gedcom!(:gedcom =>
          Rails.root.join("spec/fixtures/gedcoms/GARYSANCESTORS.GED").open)
      end

      it "should deny access" do
        delete :destroy, :id => @user.gedcom
        response.should redirect_to(root_path)
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
  
end
