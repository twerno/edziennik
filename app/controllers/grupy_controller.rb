class GrupyController < ApplicationController
  # GET /grupy
  # GET /grupy.xml
  
  def intro
    @grupy = Grupa.existing.klasa
  end
  
  
  def index
    @grupy = Grupa.existing.klasa

    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @grupy }
    end
  end

  # GET /grupy/1
  # GET /grupy/1.xml
  def show
    @grupa = Grupa.find(params[:id])

    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @grupa }
      format.js
    end
  end

  # GET /grupy/new
  # GET /grupy/new.xml
  def new
    @grupa = Grupa.new
    @uczniowie = Uczen.all
    
    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @grupa }
    end
  end

  # GET /grupy/1/edit
  def edit
    @grupa = Grupa.find(params[:id])
  end

  def nowa_klasa
    @grupa     = Grupa.new
    
    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @grupa }
    end
  end

  def klasa_create
    @grupa = Grupa.new(params[:grupa])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user
    @grupa.klasa = true

    respond_to do |format|
      if @grupa.save
        g = Grupa.new :nazwa => "Dziewczęta", :grupa_id => @grupa.id, :klasa => false
        g.set_editors_stamp get_editors_stamp
        g.set_current_user  current_user
        g.save
        g = Grupa.new :nazwa => "Chłopcy", :grupa_id => @grupa.id, :klasa => false
        g.set_editors_stamp get_editors_stamp
        g.set_current_user  current_user
        g.save
        @grupa.zarzadzaj_grupa params[:new_czlonek], params[:existing_czlonek], get_editors_stamp, current_user
        flash[:notice] = 'Grupa was successfully created.'
        format.html { redirect_to(@grupa) }
        format.xml  { render :xml => @grupa, :status => :created, :location => @grupa }
      else
        format.html { render :action => "nowa_klasa" }
        format.xml  { render :xml => @grupa.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # POST /grupy
  # POST /grupy.xml
  def create
    @grupa = Grupa.new(params[:grupa])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user
    #@grupa.klasa = true

    respond_to do |format|
      if @grupa.save
        if @grupa.klasa
          g = Grupa.new :nazwa => "Dziewczęta", :grupa_id => @grupa.id, :klasa => false
          g.save
          g = Grupa.new :nazwa => "Chłopcy", :grupa_id => @grupa.id, :klasa => false
          g.save
          @grupa.zarzadzaj_grupa params[:new_czlonek], params[:existing_czlonek], get_editors_stamp, current_user
        end  
        flash[:notice] = 'Grupa was successfully created.'
        format.html { redirect_to(@grupa) }
        format.xml  { render :xml => @grupa, :status => :created, :location => @grupa }
      else
        format.html { render :action => "nowa_klasa", :layout => 'application' }
        format.xml  { render :xml => @grupa.errors, :status => :unprocessable_entity }
      end
    end
  end

  def nowa_grupa
    @grupa = Grupa.new
    @klasa = Grupa.find(params[:id])
    @uczniowie = Uczen.all
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @grupa }
    end
  end

  def create_grupa
    @grupa = Grupa.new(params[:grupa])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user

    respond_to do |format|
      if @grupa.save
        @grupa.zarzadzaj_grupa params[:new_czlonek], params[:existing_czlonek], get_editors_stamp, current_user
        flash[:notice] = 'Grupa was successfully created.'
        format.html { redirect_to(@grupa) }
        format.xml  { render :xml => @grupa, :status => :created, :location => @grupa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @grupa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /grupy/1
  # PUT /grupy/1.xml
  def update
    params[:grupa][:existing_lista_attributes] ||= {}
    @grupa = Grupa.find(params[:id])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user

    respond_to do |format|
      if @grupa.update_attributes(params[:grupa])
        @grupa.zarzadzaj_grupa params[:new_czlonek], params[:existing_czlonek], get_editors_stamp, current_user
        flash[:notice] = 'Grupa was successfully updated.'
        format.html { redirect_to(@grupa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grupa.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def przedmioty
    @grupa = Grupa.find(params[:id])
  end

  # DELETE /grupy/1
  # DELETE /grupy/1.xml
  def destroy
    @grupa = Grupa.find(params[:id])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user
    #destroy wszystkie grupy
    @grupa.destroy

    respond_to do |format|
      format.html { redirect_to(grupy_url) }
      format.xml  { head :ok }
    end
  end
  
  def createaa
    params[:grupa][:existing_lista_attributes] ||= {}
    @grupa = Grupa.find(params[:grupa][:grupa_id])
    @grupa.set_editors_stamp get_editors_stamp
    @grupa.set_current_user  current_user
    @grupa.set get_editors_stamp, current_user

    respond_to do |format|
      if @grupa.update_attributes(params[:grupa])
        #@grupa.save_listy
        flash[:notice] = 'Grupa was successfully updated.'
        format.html { redirect_to(@grupa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @grupa.errors, :status => :unprocessable_entity }
      end
    end
  end
end
