class PlanyController < ApplicationController

  def intro
    @plany = Plan.existing.find(:all, :order => :nazwa)
  end

  def index
    @plany = Plan.existing.find(:all, :order => :nazwa)
    render :layout => 'application'
  end


  def show
    @plan = Plan.find(params[:id])
    render :layout => 'application'
  end


  def new
    @plan = Plan.new
    render :layout => 'application'
  end


  def edit
    @plan = Plan.find(params[:id])
    render :layout => 'application'    
  end


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
        format.html { render :action => "new", :layout => 'application' }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @plan = Plan.find(params[:id])
    @plan.set_editors_stamp get_editors_stamp
    @plan.set_current_user  current_user

    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        #active @plan
        flash[:notice] = 'Plan was successfully updated.'
        format.html { redirect_to(@plan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'application' }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end


  def plan
    @plan    = Plan.find(params[:id])
    #@klasa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing.find(:all, :order => :begin)
    #@lekcje = Lekcje.existing.find_all_by_semestr @plan.semestr
    render :layout => 'application'
  end  
  
  
  def plan_dla_klasy
    @plan    = Plan.find(params[:id])
    @grupa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing
    render :layout => 'application'

  end


  def plan_dla_klasy_edit
    @godzina = params[:godzina]
    @dzien   = params[:dzien]
    @plan    = Plan.find(params[:id])
    @klasa   = Grupa.find(params[:klasa])
    @godziny = Godzina.existing.all
    #@lekcje = Lekcje.existing.find_all_by_semestr @plan.semestr
  end

  

  def create_lekcja
    @l = Lekcja.existing.find(:first, :include => :lista, :conditions => ["plan_id = ? AND dzien_tygodnia = ? AND godzina_id = ? AND listy.grupa_id = ? AND listy.destroyed = ?", params[:Lekcja][:plan_id], params[:Lekcja][:dzien_tygodnia], params[:Lekcja][:godzina_id], params[:Lekcja][:grupa_id], false])
    if (params[:Lekcja][:lista_id].to_i > 0)
      if (@l.nil?)
        @l = Lekcja.new(:plan_id => params[:Lekcja][:plan_id], :dzien_tygodnia => params[:Lekcja][:dzien_tygodnia], :godzina_id => params[:Lekcja][:godzina_id], :lista_id => params[:Lekcja][:lista_id]) 
      else
        @l.set_editors_stamp get_editors_stamp
        @l.set_current_user  current_user     
        @l.destroy
        @l = Lekcja.new(:plan_id => params[:Lekcja][:plan_id], :dzien_tygodnia => params[:Lekcja][:dzien_tygodnia], :godzina_id => params[:Lekcja][:godzina_id], :lista_id => params[:Lekcja][:lista_id]) 
      end
      @l.set_editors_stamp get_editors_stamp
      @l.set_current_user  current_user
      @l.save
    elsif params[:Lekcja][:lista_id].to_i == -1
      @l.set_editors_stamp get_editors_stamp
      @l.set_current_user  current_user     
      @l.destroy
      @l = nil
    end
    
    begin
      @nazwa = @l.przedmiot.nazwa
    rescue
      @nazwa = '&nbsp;'
    end
    
    @div = params[:Lekcja][:godzina_id]+"-"+params[:Lekcja][:dzien_tygodnia]
    respond_to do |format|
        format.html
        format.js
    end
  end


  def wybierz_kom
    @dzien   = params[:dzien]
    @godzina = params[:godzina]
    @div     = params[:godzina]+"-"+params[:dzien]
    
    @plan    = Plan.find(params[:id])
    @grupa   = Grupa.find(params[:klasa])
    
    respond_to do |format|
    format.html
    format.js
  end
    #@id      = Lekcja.existing.find
  end


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
        )  unless p != plan
      end
    end
  end
  
  
end
