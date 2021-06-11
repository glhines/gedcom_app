class GedcomsController < ApplicationController

  before_action :authenticate, :only => [:create, :destroy]
  before_action :gedcom_owner, :only => :destroy

  def new
    @gedcom = Gedcom.new
    @title = "Upload GEDCOM File"
  end

  def create
    begin
      @gedcom = current_user.build_gedcom(params[:gedcom])
      if @gedcom.save
        flash[:success] = "GEDCOM uploaded!"
        redirect_to root_path
      else
        render 'new'
      end
    rescue
      flash[:error] = "Error uploading GEDCOM: #{$!}"
      @gedcom = Gedcom.new
      render 'new'
    end
  end
    
  def show
    # For added security, we allow the user to only see his own gedcom
    #@gedcom = Gedcom.find(params[:id])
    @gedcom = current_user.gedcom
    @title = @gedcom.gedcom_file_name
  end

  def destroy
    @gedcom.destroy
    flash[:success] = "GEDCOM deleted."
    redirect_back_or root_path
  end

  def birthplaces
    birthplaces_report(true) 
  end

  def rollup 
    birthplaces_report(false) 
  end

  private

    def gedcom_owner
      @gedcom = Gedcom.find(params[:id])
      redirect_to root_path if @gedcom.nil? || !current_user?(@gedcom.user)
    end

    def birthplaces_report detail
      @title = "Birthplaces"
      # For added security, we allow the user to only see his own gedcom
      #@gedcom = Gedcom.find(params[:id])
      @gedcom = current_user.gedcom
      parser = GedcomsHelper::GedcomFile.new( @gedcom.gedcom )
      parser.parse_gedcom
      @transcoder = parser.transcoder
      @detail = detail
      if detail then
        @birthplaces = parser.report_birthplaces
      else
        @birthplaces = parser.report_birthplaces_rollup
      end    
      @sum = 0
      @birthplaces.each { |key, value| @sum += value }
      render 'show_birthplaces'
    end
  
end
