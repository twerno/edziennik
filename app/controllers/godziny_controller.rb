class GodzinyController < ApplicationController
  #layout "application"
  # GET /godziny
  # GET /godziny.xml
  def index
    @godziny = Godzina.existing.find(:all, :order => :begin)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @godziny }
    end
  end

  # GET /godziny/1
  # GET /godziny/1.xml
  def show
    @godzina = Godzina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @godzina }
    end
  end

  # GET /godziny/new
  # GET /godziny/new.xml
  def new
    @godzina = Godzina.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @godzina }
    end
  end

  # GET /godziny/1/edit
  def edit
    @godzina = Godzina.find(params[:id])
    #render :layout => "application"
  end

  # POST /godziny
  # POST /godziny.xml
  def create
    @godzina = Godzina.new(params[:godzina])
    @godzina.set_editors_stamp get_editors_stamp
    @godzina.set_current_user  current_user

    respond_to do |format|
      if @godzina.save
        flash[:notice] = 'Godzina was successfully created.'
        format.html { redirect_to(@godzina) }
        format.xml  { render :xml => @godzina, :status => :created, :location => @godzina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @godzina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /godziny/1
  # PUT /godziny/1.xml
  def update
    @godzina = Godzina.find(params[:id])
    @godzina.set_editors_stamp get_editors_stamp
    @godzina.set_current_user  current_user

    respond_to do |format|
      if @godzina.update_attributes(params[:godzina])
        flash[:notice] = 'Godzina was successfully updated.'
        format.html { redirect_to(@godzina) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @godzina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /godziny/1
  # DELETE /godziny/1.xml
  def destroy
    @godzina = Godzina.find(params[:id])
    @godzina.set_editors_stamp get_editors_stamp
    @godzina.set_current_user  current_user
    @godzina.destroy

    respond_to do |format|
      format.html { redirect_to(godziny_url) }
      format.xml  { head :ok }
    end
  end
end
