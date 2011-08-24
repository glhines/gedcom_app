class GedcomsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :gedcom_owner, :only => :destroy

  def new
    @gedcom = Gedcom.new
    @title = "Upload GEDCOM File"
  end

  def create
    @gedcom = current_user.build_gedcom(params[:gedcom])
    if @gedcom.save
      flash[:success] = "GEDCOM uploaded!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end
    
  def show
    @gedcom = Gedcom.find(params[:id])
    @title = @gedcom.gedcom_file_name
  end

  def destroy
    @gedcom.destroy
    flash[:success] = "GEDCOM deleted."
    redirect_back_or root_path
  end

  private

    def gedcom_owner
      @gedcom = Gedcom.find(params[:id])
      redirect_to root_path if @gedcom.nil? || !current_user?(@gedcom.user)
    end
end
