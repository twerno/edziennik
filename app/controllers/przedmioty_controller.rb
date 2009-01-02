class PrzedmiotyController < ApplicationController
  # GET /przedmioty
  # GET /przedmioty.xml
  def index
    @przedmioty = Przedmiot.existing.find(:all, :order => :nazwa)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @przedmioty }
    end
  end

  # GET /przedmioty/1
  # GET /przedmioty/1.xml
  def show
    @przedmiot = Przedmiot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @przedmiot }
    end
  end

  # GET /przedmioty/new
  # GET /przedmioty/new.xml
  def new
    @przedmiot = Przedmiot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @przedmiot }
    end
  end

  # GET /przedmioty/1/edit
  def edit
    @przedmiot = Przedmiot.find(params[:id])
  end

  # POST /przedmioty
  # POST /przedmioty.xml
  def create
    @przedmiot = Przedmiot.new(params[:przedmiot])

    respond_to do |format|
      if @przedmiot.save
        flash[:notice] = 'Przedmiot was successfully created.'
        format.html { redirect_to(@przedmiot) }
        format.xml  { render :xml => @przedmiot, :status => :created, :location => @przedmiot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @przedmiot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /przedmioty/1
  # PUT /przedmioty/1.xml
  def update
    @przedmiot = Przedmiot.find(params[:id])

    respond_to do |format|
      if @przedmiot.update_attributes(params[:przedmiot])
        flash[:notice] = 'Przedmiot was successfully updated.'
        format.html { redirect_to(@przedmiot) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @przedmiot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /przedmioty/1
  # DELETE /przedmioty/1.xml
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
