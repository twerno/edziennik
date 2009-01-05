class UczniowieController < ApplicationController
  # GET /uczniowie
  # GET /uczniowie.xml
  def index
    @uczniowie = Uczen.existing.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @uczniowie }
    end
  end

  # GET /uczniowie/1
  # GET /uczniowie/1.xml
  def show
    @uczen = Uczen.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @uczen }
    end
  end

  # GET /uczniowie/new
  # GET /uczniowie/new.xml
  def new
    @uczen = Uczen.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @uczen }
    end
  end

  # GET /uczniowie/1/edit
  def edit
    @uczen = Uczen.find(params[:id])
  end

  # POST /uczniowie
  # POST /uczniowie.xml
  def create
    @uczen = Uczen.new(params[:uczen])

    respond_to do |format|
      if @uczen.save
        flash[:notice] = 'Uczen was successfully created.'
        format.html { redirect_to(@uczen) }
        format.xml  { render :xml => @uczen, :status => :created, :location => @uczen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @uczen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uczniowie/1
  # PUT /uczniowie/1.xml
  def update
    @uczen = Uczen.find(params[:id])

    respond_to do |format|
      if @uczen.update_attributes(params[:uczen])
        flash[:notice] = 'Uczen was successfully updated.'
        format.html { redirect_to(@uczen) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @uczen.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uczniowie/1
  # DELETE /uczniowie/1.xml
  def destroy
    @uczen = Uczen.find(params[:id])
    @uczen.destroy

    respond_to do |format|
      format.html { redirect_to(uczniowie_url) }
      format.xml  { head :ok }
    end
  end
end
