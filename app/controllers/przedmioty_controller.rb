class PrzedmiotyController < ApplicationController
  before_filter :admin_rights

  def intro
    @przedmioty = Przedmiot.existing.find(:all, :order => :nazwa)    
  end

  def index
    @przedmioty = Przedmiot.existing.find(:all, :order => :nazwa)
    render :layout => 'application'
  end


  def show
    @przedmiot = Przedmiot.find(params[:id])
    render :layout => 'application'
  end


  def new
    @przedmiot = Przedmiot.new
    render :layout => 'application'
  end


  def edit
    @przedmiot = Przedmiot.find(params[:id])
    render :layout => 'application'    
  end


  def create
    @przedmiot = Przedmiot.new(params[:przedmiot])

    respond_to do |format|
      if @przedmiot.save
        flash[:notice] = 'Przedmiot was successfully created.'
        format.html { redirect_to(@przedmiot) }
        format.xml  { render :xml => @przedmiot, :status => :created, :location => @przedmiot }
      else
        format.html { render :action => "new", :layout => 'application' }
        format.xml  { render :xml => @przedmiot.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @przedmiot = Przedmiot.find(params[:id])

    respond_to do |format|
      if @przedmiot.update_attributes(params[:przedmiot])
        flash[:notice] = 'Przedmiot was successfully updated.'
        format.html { redirect_to(@przedmiot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'application' }
        format.xml  { render :xml => @przedmiot.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @przedmiot = Nauczyciel.find(params[:id])
    @przedmiot.set_editors_stamp get_editors_stamp
    @przedmiot.set_current_user current_user
    @przedmiot.pnjts.each do |pnjt|
          pnjt.set_editors_stamp get_editors_stamp
          pnjt.set_current_user current_user
          pnjt.destroy
    end
    @przedmiot.destroy

    respond_to do |format|
      format.html { redirect_to(przedmioty_url) }
      format.xml  { head :ok }
    end
  end
end
