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

    before(:each) do
      @user = Factory(:user)
      @user = test_sign_in(@user)
    end

    after(:each) do
      @user.destroy
    end

    describe "failure" do

      before(:each) do
        @attr = { :gedcom => nil }
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
        @gedcom = Gedcom.new
        @gedcom.gedcom = File.new(Rails.root.join('spec/fixtures/gedcoms/GARYSANCESTORS.GED'))
        @attr = { :gedcom => @gedcom.gedcom }
      end

      #after(:each) do
      #  current_user.gedcom.destroy
      #end

      it "should create a gedcom" do
        lambda do
          post :create, @attr
        end.should change(Gedcom, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, @attr
        flash[:success].should =~ /gedcom uploaded/i
      end
    end
  end

end
