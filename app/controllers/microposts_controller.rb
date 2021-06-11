class MicropostsController < ApplicationController
  before_action :authenticate, :only => [:create, :destroy]
  before_action :authorized_user, :only => :destroy
  
  def create
    @micropost  = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private

    def authorized_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end

    def micropost_params
      params.require(:micropost).permit(:user_id, :content)
    end

end
