class PlanyController < ApplicationController
  # GET /plany
  # GET /plany.xml
  def index
    @plany = Plan.existing.find(:all, :order => :nazwa)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plany }
    end
  end

  # GET /plany/1
  # GET /plany/1.xml
  def show
    @plan = Plan.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plan }
    end
  end

  # GET /plany/new
  # GET /plany/new.xml
  def new
    @plan = Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plan }
    end
  end

  # GET /plany/1/edit
  def edit
    @plan = Plan.find(params[:id])
  end

  # POST /plany
  # POST /plany.xml
  def create
    @plan = Plan.new(params[:plan])
    @plan.set_editors_stamp get_editors_stamp
    @plan.set_current_user  current_user

    respond_to do |format|
      if @plan.save
        active @plan
        flash[:notice] = 'Plan was successfully created.'
        format.html { redirect_to(@plan) }
        format.xml  { render :xml => @plan, :status => :created, :location => @plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plany/1
  # PUT /plany/1.xml
  def update
    @plan = Plan.find(params[:id])
    @plan.set_editors_stamp get_editors_stamp
    @plan.set_current_user  current_user

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        active @plan
        flash[:notice] = 'Plan was successfully updated.'
        format.html { redirect_to(@plan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def plan
    @plan    = Plan.find(params[:id])
    #@klasa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing.all
    #@lekcje = Lekcje.existing.find_all_by_semestr @plan.semestr
  end  
  
  
  def plan_dla_klasy
    @plan    = Plan.find(params[:id])
    @klasa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing.all

  end
  
  def plan_dla_klasy_edit
    @godzina = params[:godzina]
    @dzien   = params[:dzien]
    @plan    = Plan.find(params[:id])
    @klasa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing.all
    #@lekcje = Lekcje.existing.find_all_by_semestr @plan.semestr
  end

  # DELETE /plany/1
  # DELETE /plany/1.xml
  def destroy
    @plan = Plan.find(params[:id])
    @plan.set_editors_stamp get_editors_stamp
    @plan.set_current_user  current_user
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to(plany_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  def active plan
    if plan.active
      Plan.existing.active.each do |p|
        ( 
          p.active = false 
          p.set_editors_stamp get_editors_stamp
          p.set_current_user  current_user
          p.save
        )  unless p == plan
      end
    end
  end
  
  
end
