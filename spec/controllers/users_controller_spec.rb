require 'rails_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do

    describe "for non-signed-in users" do
      it "should deny access" do
        get :index
        expect(response).to redirect_to(signin_path)
        expect(flash[:notice]).to match(/sign in/i)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        @base_title = "Uncle Lloyd | "
        @user = test_sign_in(FactoryBot.create(:user))
        second = FactoryBot.create(:user, :name => "Bob", :email => "another@example.com")
        third  = FactoryBot.create(:user, :name => "Ben", :email => "another@example.net")

        @users = [@user, second, third]
        30.times do
          @users << FactoryBot.create(:user, :email => FactoryBot.generate(:email))
        end
      end

      it "should be successful" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "should have the right title" do
        get :index
        expect(response.body).to have_title(@base_title + "All users")
      end

      it "should have an element for each user" do
        get :index
        @users[0..2].each do |user|
          expect(response.body).to have_selector("li", :text => user.name)
        end
      end

      it "should paginate users" do
        get :index
        expect(response.body).to have_selector("div.pagination")
        expect(response.body).to have_selector("span.disabled", :text => "Previous")
        expect(response.body).to have_link("2", :href => "/users?page=2")
        expect(response.body).to have_link("Next", :href => "/users?page=2")
      end
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    it "should be successful" do
      # get :show, :id => @user
      # response.should be_success
      get :show, :params => { :id => @user }
      expect(response).to have_http_status(:success)
    end

    it "should find the right user" do
      get :show, :params => { :id => @user }
      expect(assigns(:user)).to eq(@user)
    end

    it "should have the right title" do
      # response.should have_selector("title", :content => @user.name)
      get :show, :params => { :id => @user }
      expect(response.body).to have_title(@user.name)
    end

    it "should include the user's name" do
      get :show, :params => { :id => @user }
      expect(response.body).to have_selector("h1", :text => @user.name)
    end

    it "should have a profile image" do
      get :show, :params => { :id => @user }
      expect(response.body).to have_selector("h1>img", :class => "gravatar")
    end

    it "should show the user's microposts" do
      mp1 = FactoryBot.create(:micropost, :user => @user, :content => "Foo bar")
      mp2 = FactoryBot.create(:micropost, :user => @user, :content => "Baz quux")
      get :show, :params => { :id => @user }
      expect(response.body).to have_selector("span.content", :text => mp1.content)
      expect(response.body).to have_selector("span.content", :text => mp2.content)
    end
    
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should have the right title" do
      @base_title = "Uncle Lloyd | "
      get :new
      expect(response.body).to have_title(@base_title + "Sign up")
    end

    it "should have a name field" do
      get :new
      expect(response.body).to have_selector("input[name='user[name]'][type='text']")
    end

    it "should have an email field" do
      get :new
      expect(response.body).to have_selector("input[name='user[email]'][type='text']")
    end

    it "should have a password field" do
      get :new
      expect(response.body).to have_selector("input[name='user[password]'][type='password']")
    end

    it "should have a password confirmation field" do
      get :new
      expect(response.body).to have_selector("input[name='user[password_confirmation]'][type='password']")
    end

  end

  describe "POST 'create'" do

    describe "failure" do

      before(:each) do
        @base_title = "Uncle Lloyd | "
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        expect do
          post :create, :params => { :user => @attr }
        end.not_to change(User, :count)
      end

      it "should have the right title" do
        post :create, :params => { :user => @attr }
        expect(response.body).to have_title(@base_title + "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :params => { :user => @attr }
        expect(response.body).to render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        expect do
          post :create, :params => { :user => @attr }
        end.to change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :params => { :user => @attr }
        expect(response).to redirect_to(user_path(assigns(:user)))
      end    

      it "should have a welcome message" do
        post :create, :params => { :user => @attr }
        expect(flash[:success]).to match(/welcome to uncle lloyd/i)
      end

      it "should sign the user in" do
        post :create, :params => { :user => @attr }
        expect(controller).to be_signed_in
      end

    end
    
  end

  describe "GET 'edit'" do

    before(:each) do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :params => { :id => @user }
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get :edit, :params => { :id => @user }
      expect(response.body).to have_title("Edit user")
    end

    it "should prompt to upload a GEDCOM file" do
      get :edit, :params => { :id => @user }
      expect(response.body).to have_link("Click here to upload GEDCOM!")
      # response.should have_selector("a",
      #                              :content => "Click here to upload GEDCOM!")
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @user = FactoryBot.create(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :email => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the 'edit' page" do
        put :update, :params => { :id => @user, :user => @attr }
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.warn(e)
          # expect(response).to render_template('edit')
      end

      it "should have the right title" do
        put :update, :params => { :id => @user, :user => @attr }
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.warn(e)
          # expect(response.body).to have_title("Edit user"))
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New Name", :email => "user@example.org",
                  :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do
        put :update, :params => { :id => @user, :user => @attr }
        @user.reload
        expect(@user.name).to eq(@attr[:name])
        expect(@user.email).to eq(@attr[:email])
      end

      it "should redirect to the user show page" do
        put :update, :params => { :id => @user, :user => @attr }
        expect(response).to redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :params => { :id => @user, :user => @attr }
        expect(flash[:success]).to match(/updated/)
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :params => { :id => @user }
        expect(response).to redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :params => { :id => @user, :user => {} }
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = FactoryBot.create(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :params => { :id => @user }
        expect(response).to redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :params => { :id => @user, :user => {} }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE 'destroy'" do

    before(:each) do
      @user = FactoryBot.create(:user)
    end

    describe "as a non-signed-in user" do
      it "should deny access" do
        delete :destroy, :params => { :id => @user }
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "as a non-admin user" do
      it "should protect the page" do
        test_sign_in(@user)
        delete :destroy, :params => { :id => @user }
        expect(response).to redirect_to(root_path)
      end
    end

    describe "as an admin user" do

      before(:each) do
        admin = FactoryBot.create(:user, :email => "admin@example.com", :admin => true)
        test_sign_in(admin)
      end

      it "should destroy the user" do
        expect do
          delete :destroy, :params => { :id => @user }
        end.to change(User, :count).by(-1)
      end

      it "should redirect to the users page" do
        delete :destroy, :params => { :id => @user }
        expect(response).to redirect_to(users_path)
      end
    end
  end

  describe "follow pages" do

    describe "when not signed in" do

      it "should protect 'following'" do
        get :following, :params => { :id => 1 }
        expect(response).to redirect_to(signin_path)
      end

      it "should protect 'followers'" do
        get :followers, :params => { :id => 1 }
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(FactoryBot.create(:user))
        @other_user = FactoryBot.create(:user, :email => FactoryBot.generate(:email))
        @user.follow!(@other_user)
      end

      it "should show user following" do
        get :following, :params => { :id => @user }
        expect(response.body).to have_link(@other_user.name, :href => user_path(@other_user))
      end

      it "should show user followers" do
        get :followers, :params => { :id => @other_user }
        expect(response.body).to have_link(@user.name, :href => user_path(@user))
      end
    end
  end
  
end
