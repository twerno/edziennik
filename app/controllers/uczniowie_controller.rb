class UczniowieController < ApplicationController
  before_filter :admin_rights

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
    @rodzic = @uczen.rodzic
    render :layout => 'application'
  end


  def create
    #begin
      r = Rodzic.new params[:rodzic]
      r.set_editors_stamp get_editors_stamp
      r.set_current_user  current_user
      @uczen = Uczen.new(params[:uczen])
      @uczen.set_editors_stamp get_editors_stamp
      @uczen.set_current_user  current_user
      
      if params[:rodzic][:pesel] != params[:uczen][:pesel] && r.save
        #@uczen = Uczen.new(params[:uczen])
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
    @uczen.set_editors_stamp get_editors_stamp
    @uczen.set_current_user  current_user    
    r = @uczen.rodzic
    r.set_editors_stamp get_editors_stamp
    r.set_current_user  current_user
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
      
      y0 = pdf.y + 18
      y0 = pdf.y + 18
      pdf.stroke_color  Color::RGB::Navy
      pdf.rounded_rectangle(pdf.left_margin + 25, y0-15, pdf.margin_width-50,y0 - pdf.y + 18, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-65, pdf.margin_width-100, y0 - pdf.y + 75, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-175, pdf.margin_width-100, y0 - pdf.y + 75, 10).stroke
      
      pdf.text "<b>TWORZENIE KONTA</b>", :font_size => 20, :justification => :center
      pdf.text "Utworzone zostalo nowe konto dla ucznia: ", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << u.imie << " " << u.nazwisko, :font_size => 12, :justification => :center
      pdf.text "</b>Dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << u.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120
     
      
      r = u.rodzic
      us= User.new :login => r.pesel
      haslo = u.new_key
      us.password = haslo
      us.rodzic_id = r.id
      us.save(false)
      us.register!
      us.activate!
      
      pdf.text "Utworzone zostalo nowe konto dla rodzica ucznia: ", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << u.imie << " " << u.nazwisko, :font_size => 12, :justification => :center
      pdf.text "</b>Dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << r.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120
      
    end
    
    for i in (params["haslo"].nil?) ? [] : params["haslo"].keys
      
      pdf.start_new_page unless j
      j = false
      
      u = Uczen.find i.to_i
      us= u.user
      haslo = u.new_key
      us.password = haslo
      us.save(false)

      y0 = pdf.y + 18
      pdf.stroke_color  Color::RGB::Navy
      pdf.rounded_rectangle(pdf.left_margin + 25, y0-15, pdf.margin_width-50,y0 - pdf.y + 18, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-65, pdf.margin_width-100, y0 - pdf.y + 75, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-175, pdf.margin_width-100, y0 - pdf.y + 75, 10).stroke

      pdf.text "<b>ZMIANA HASLA</b>", :font_size => 20, :justification => :center
      pdf.text "Utworzone zostalo nowe haslo dla ucznia:", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << u.imie << " " << u.nazwisko, :font_size => 12, :justification => :center

      pdf.text "</b>Nowe dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << u.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120
    
      
   
      r = u.rodzic
      us= r.user
      haslo = u.new_key
      us.password = haslo
      us.save(false)

      pdf.text "Utworzone zostalo nowe haslo dla rodzica ucznia:", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << u.imie << " " << u.nazwisko, :font_size => 12, :justification => :center

      pdf.text "</b>Nowe dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << r.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120
   
      
    end
     
    send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline' unless params["haslo"].nil? & params["konto"].nil?
    redirect_to :action => :index unless !(params["haslo"].nil? & params["konto"].nil?)
  end
end
