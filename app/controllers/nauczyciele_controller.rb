class NauczycieleController < ApplicationController
  # GET /nauczyciele
  # GET /nauczyciele.xml
  def index
    @nauczyciele = Nauczyciel.existing.find(:all, :order => :nazwisko)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nauczyciele }
    end
  end

  # GET /nauczyciele/1
  # GET /nauczyciele/1.xml
  def show
    @nauczyciel = Nauczyciel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nauczyciel }
    end
  end

  # GET /nauczyciele/new
  # GET /nauczyciele/new.xml
  def new
    @nauczyciel = Nauczyciel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nauczyciel }
    end
  end

  # GET /nauczyciele/1/edit
  def edit
    @nauczyciel = Nauczyciel.find(params[:id])
  end

  # POST /nauczyciele
  # POST /nauczyciele.xml
  def create
    @nauczyciel = Nauczyciel.new(params[:nauczyciel])
    @nauczyciel.set_editors_stamp get_editors_stamp
    @nauczyciel.set_current_user current_user


    respond_to do |format|
      if @nauczyciel.save
        flash[:notice] = 'Nauczyciel was successfully created.'
        @nauczyciel.zarzadzaj_grupa params[:new_nauczyciel], params[:existing_nauczyciel], get_editors_stamp, current_user
        format.html { redirect_to(@nauczyciel) }
        format.xml  { render :xml => @nauczyciel, :status => :created, :location => @nauczyciel }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nauczyciel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nauczyciele/1
  # PUT /nauczyciele/1.xml
  def update
    @nauczyciel = Nauczyciel.find(params[:id])
    @nauczyciel.set_editors_stamp get_editors_stamp
    @nauczyciel.set_current_user current_user
    
    respond_to do |format|
      if @nauczyciel.update_attributes(params[:nauczyciel])
        @nauczyciel.zarzadzaj_grupa params[:new_nauczyciel], params[:existing_nauczyciel], get_editors_stamp, current_user
        flash[:notice] = 'Nauczyciel was successfully updated.'
        format.html { redirect_to(@nauczyciel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nauczyciel.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nauczyciele/1
  # DELETE /nauczyciele/1.xml
  def destroy
    @nauczyciel = Nauczyciel.find(params[:id])
    @nauczyciel.set_editors_stamp get_editors_stamp
    @nauczyciel.set_current_user current_user
    @nauczyciel.pnjts.each do |pnjt|
          pnjt.set_editors_stamp get_editors_stamp
          pnjt.set_current_user current_user
          pnjt.destroy
    end
    @nauczyciel.destroy

    respond_to do |format|
      format.html { redirect_to(nauczyciele_url) }
      format.xml  { head :ok }
    end
  end
end
