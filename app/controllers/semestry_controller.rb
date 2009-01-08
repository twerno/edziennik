class SemestryController < ApplicationController

  def intro
    @semestry = Semestr.existing
  end

  def index
    @semestry = Semestr.existing
    render :layout => 'application'
  end


  def show
    @semestr = Semestr.find(params[:id])
    render :layout => 'application'
  end


  def new
    @semestr = Semestr.new
    render :layout => 'application'
  end


  def edit
    @semestr = Semestr.find(params[:id])
    render :layout => 'application'    
  end


  def create
    @semestr = Semestr.new(params[:semestr])
    @semestr.set_editors_stamp get_editors_stamp
    @semestr.set_current_user  current_user

    respond_to do |format|
      if @semestr.save
        flash[:notice] = 'Semestr was successfully created.'
        format.html { redirect_to(@semestr) }
        format.xml  { render :xml => @semestr, :status => :created, :location => @semestr }
      else
        format.html { render :action => "new", :layout => 'application' }
        format.xml  { render :xml => @semestr.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @semestr = Semestr.find(params[:id])
    @semestr.set_editors_stamp get_editors_stamp
    @semestr.set_current_user  current_user

    respond_to do |format|
      if @semestr.update_attributes(params[:semestr])
        flash[:notice] = 'Semestr was successfully updated.'
        format.html { redirect_to(@semestr) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'application' }
        format.xml  { render :xml => @semestr.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @semestr = Semestr.find(params[:id])
    @semestr.set_editors_stamp get_editors_stamp
    @semestr.set_current_user  current_user
    @semestr.destroy

    respond_to do |format|
      format.html { redirect_to(semestry_url) }
      format.xml  { head :ok }
    end
  end
end
