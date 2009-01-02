class SemestryController < ApplicationController
  # GET /semestry
  # GET /semestry.xml
  def index
    @semestry = Semestr.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @semestry }
    end
  end

  # GET /semestry/1
  # GET /semestry/1.xml
  def show
    @semestr = Semestr.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @semestr }
    end
  end

  # GET /semestry/new
  # GET /semestry/new.xml
  def new
    @semestr = Semestr.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @semestr }
    end
  end

  # GET /semestry/1/edit
  def edit
    @semestr = Semestr.find(params[:id])
  end

  # POST /semestry
  # POST /semestry.xml
  def create
    @semestr = Semestr.new(params[:semestr])

    respond_to do |format|
      if @semestr.save
        flash[:notice] = 'Semestr was successfully created.'
        format.html { redirect_to(@semestr) }
        format.xml  { render :xml => @semestr, :status => :created, :location => @semestr }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @semestr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /semestry/1
  # PUT /semestry/1.xml
  def update
    @semestr = Semestr.find(params[:id])

    respond_to do |format|
      if @semestr.update_attributes(params[:semestr])
        flash[:notice] = 'Semestr was successfully updated.'
        format.html { redirect_to(@semestr) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @semestr.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /semestry/1
  # DELETE /semestry/1.xml
  def destroy
    @semestr = Semestr.find(params[:id])
    @semestr.destroy

    respond_to do |format|
      format.html { redirect_to(semestry_url) }
      format.xml  { head :ok }
    end
  end
end
