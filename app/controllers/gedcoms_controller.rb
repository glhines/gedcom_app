class GedcomsController < ApplicationController

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :gedcom_owner, :only => :destroy

  def new
    @gedcom = Gedcom.new
    @title = "Upload GEDCOM File"
  end

  def create
    begin
      @gedcom = current_user.build_gedcom!(params[:gedcom])
      if @gedcom.save
        flash[:success] = "GEDCOM uploaded!"
        redirect_to root_path
      else
        render 'new'
      end
    rescue
      flash[:error] = "Error uploading GEDCOM!"
      @gedcom = Gedcom.new
      render 'new'
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

  def birthplaces
    @title = "Birthplaces"
    @gedcom = Gedcom.find(params[:id])
    parser = GedcomsHelper::GedcomFile.new( @gedcom.gedcom )
    parser.parse_gedcom
    @birthplaces = parser.report_birthplaces
    render 'show_birthplaces'
  end

  private

    def gedcom_owner
      @gedcom = Gedcom.find(params[:id])
      redirect_to root_path if @gedcom.nil? || !current_user?(@gedcom.user)
    end
end
