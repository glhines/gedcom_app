class PagesController < ApplicationController

  def home
    @title = "Home"
    if signed_in?
      @micropost = Micropost.new
      @feed_items = current_user.feed.paginate(:page => params[:page])
      @gedcom = current_user.gedcom
    end
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help 
    @title = "Help"
  end

end
