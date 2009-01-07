class UczniowieController < ApplicationController
  # GET /uczniowie
  # GET /uczniowie.xml
  def index
    @uczniowie = Uczen.existing.find(:all)

    respond_to do |format|
      format.html #
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
    r = Rodzic.new params[:rodzic]
    r.save
    @uczen = Uczen.new(params[:uczen])
    @uczen.rodzic_id = r.id

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
        @uczen.rodzic.update_attributes(params[:rodzic])
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
  
  def konta
    pdf = PDF::Writer.new
    pdf.select_font "Times-Roman"
    
    j= true
    
    for i in (params["konto"].nil?) ? [] : params["konto"].keys
      
      pdf.start_new_page unless j
      j = false
      
      u = Uczen.find i.to_i
      us= User.new :login => u.pesel
      haslo = u.new_key
      us.password = haslo
      us.uczen_id = u.id
      us.save(false)
      us.register!
      us.activate!
      
      pdf.text "Utworzono nowe konto dla ucznia: " << u.imie << " " << u.nazwisko
      pdf.text "Dane do logowania:"
      pdf.text "login:" << u.pesel
      pdf.text "haslo:" << haslo
      
      
      r = u.rodzic
      us= User.new :login => r.pesel
      haslo = u.new_key
      us.password = haslo
      us.rodzic_id = r.id
      us.save(false)
      us.register!
      us.activate!
      
      pdf.text "Utworzono nowe konto dla rodzica ucznia: " << u.imie << " " << u.nazwisko
      pdf.text "Dane do logowania:"
      pdf.text "login:" << r.pesel
      pdf.text "haslo:" << haslo
      
    end
    
    for i in (params["haslo"].nil?) ? [] : params["haslo"].keys
      
      pdf.start_new_page unless j
      j = false
      
      u = Uczen.find i.to_i
      us= u.user
      haslo = u.new_key
      us.password = haslo
      us.save(false)

      
      pdf.text "Utworzono nowe haslo dla ucznia: " << u.imie << " " << u.nazwisko
      pdf.text "Dane do logowania:"
      pdf.text "login:" << u.pesel
      pdf.text "haslo:" << haslo
      
      
      r = u.rodzic
      us= r.user
      haslo = u.new_key
      us.password = haslo
      us.save(false)

      
      pdf.text "Utworzono nowe konto dla rodzica ucznia: " << u.imie << " " << u.nazwisko
      pdf.text "Dane do logowania:"
      pdf.text "login:" << r.pesel
      pdf.text "haslo:" << haslo
      
    end
     
    send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline' unless params["haslo"].nil? & params["konto"].nil?
    redirect_to :action => :index unless !(params["haslo"].nil? & params["konto"].nil?)
  end
  

  
end
