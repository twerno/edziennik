class UczniowieController < ApplicationController

  def intro
    @uczniowie = Uczen.existing.find(:all)
  end


  def index
    @uczniowie = Uczen.existing.find(:all)
    render :layout => 'application'
  end


  def show
    @uczen = Uczen.find(params[:id])

    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @uczen }
    end
  end


  def new
    @uczen = Uczen.new

    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @uczen }
    end
  end


  def edit
    @uczen = Uczen.find(params[:id])
    render :layout => 'application'
  end


  def create
    #begin
      r = Rodzic.new params[:rodzic]
      @uczen = Uczen.new(params[:uczen])
      
      if params[:rodzic][:pesel] != params[:uczen][:pesel] && r.save
        @uczen = Uczen.new(params[:uczen])
        @uczen.rodzic_id = r.id
        if @uczen.save
          flash[:notice] = 'Uczen was successfully created.'
          redirect_to uczniowie_path
        else
          render :action => "new", :layout => 'application'
        end
      else
        render :action => "new", :layout => 'application'
      end  
    #rescue
      #@uczen = Uczen.new(params[:uczen])
      #render :action => "new", :layout => 'application'
    #end  
  end


  def update
    @uczen = Uczen.find(params[:id])
    r = @uczen.rodzic

    respond_to do |format|
      if @uczen.update_attributes(params[:uczen]) && r.update_attributes(params[:rodzic])
        flash[:notice] = 'Uczen was successfully updated.'
        format.html { redirect_to uczniowie_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'application' }
        format.xml  { render :xml => @uczen.errors, :status => :unprocessable_entity }
      end
    end
  end



  def destroy
    @uczen = Uczen.find(params[:id])
    @uczen.set_editors_stamp get_editors_stamp
    @uczen.set_current_user current_user
    @uczen.destroy
    redirect_to uczniowie_path
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
