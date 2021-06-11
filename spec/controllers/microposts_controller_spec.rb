require 'rails_helper'

describe MicropostsController do
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

    before(:each) do
      @user = test_sign_in(FactoryBot.create(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a micropost" do
        expect do
          post :create, :params => { :micropost => @attr }
        end.not_to change(Micropost, :count)
      end

      it "should render the home page" do
        post :create, :params => { :micropost => @attr }
        expect(response).to render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a micropost" do
        expect do
          post :create, :params => { :micropost => @attr }
        end.to change(Micropost, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :params => { :micropost => @attr }
        expect(response).to redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :params => { :micropost => @attr }
        expect(flash[:success]).to match(/micropost created/i)
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = FactoryBot.create(:user)
        wrong_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))
        test_sign_in(wrong_user)
        @micropost = FactoryBot.create(:micropost, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :params => { :id => @micropost }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(FactoryBot.create(:user))
        @micropost = FactoryBot.create(:micropost, :user => @user)
      end

      it "should destroy the micropost" do
        expect do
          delete :destroy, :params => { :id => @micropost }
        end.to change(Micropost, :count).by(-1)
      end
    end
  end
  
end
