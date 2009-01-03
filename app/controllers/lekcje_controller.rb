class LekcjeController < ApplicationController
  # GET /lekcje
  # GET /lekcje.xml
  def index
    @lekcje = Lekcja.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @lekcje }
    end
  end

  # GET /lekcje/1
  # GET /lekcje/1.xml
  def show
    @lekcja = Lekcja.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @lekcja }
    end
  end

  # GET /lekcje/new
  # GET /lekcje/new.xml
  def new
    @lekcja = Lekcja.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lekcja }
    end
  end

  # GET /lekcje/1/edit
  def edit
    @lekcja = Lekcja.find(params[:id])
  end

  # POST /lekcje
  # POST /lekcje.xml
  def create
    @lekcja = Lekcja.new(params[:lekcja])

    respond_to do |format|
      if @lekcja.save
        flash[:notice] = 'Lekcja was successfully created.'
        format.html { redirect_to(@lekcja) }
        format.xml  { render :xml => @lekcja, :status => :created, :location => @lekcja }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lekcja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lekcje/1
  # PUT /lekcje/1.xml
  def update
    @lekcja = Lekcja.find(params[:id])

    respond_to do |format|
      if @lekcja.update_attributes(params[:lekcja])
        flash[:notice] = 'Lekcja was successfully updated.'
        format.html { redirect_to(@lekcja) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lekcja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lekcje/1
  # DELETE /lekcje/1.xml
  def destroy
    @lekcja = Lekcja.find(params[:id])
    @lekcja.destroy

    respond_to do |format|
      format.html { redirect_to(lekcje_url) }
      format.xml  { head :ok }
    end
  end
  
  def plan_dla_klasy
    puts Lekcja.existing.find(:all, :conditions => ["godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ? ", params[:godzina], params[:id], params[:dzien]])
    puts "+===========+"
    puts params[:godzina]
    puts params[:id]
    puts params[:dzien]
    puts "+===========+"
    plan2 = (plan.empty?) ? Lekcja.new(:godzina_id => params[:godzina], :plan_id => params[:id], :dzien_tygodnia => params[:dzien]) : plan
    puts plan2.empty?
    puts plan2.new_record?

  end
end
