class NauczycieleController < ApplicationController


  def intro
    @nauczyciele = Nauczyciel.existing.find(:all, :order => :nazwisko)
    respond_to do |format|
      format.html #{render :layout => 'application'}
      format.xml  { render :xml => @nauczyciele }
    end
  end


  def index
    @nauczyciele = Nauczyciel.existing.find(:all, :order => :nazwisko)

    respond_to do |format|
      format.html {render :layout => 'application'}
      format.xml  { render :xml => @nauczyciele }
    end
  end


  def show
    @nauczyciel = Nauczyciel.find(params[:id])
    render :layout => 'application'
  end


  def new
    @nauczyciel = Nauczyciel.new

    respond_to do |format|
      format.html {render :layout => "application"}
      format.xml  { render :xml => @nauczyciel }
    end
  end


  def edit
    @nauczyciel = Nauczyciel.find(params[:id])
    render :layout => "application"
  end


  def create
    @nauczyciel = Nauczyciel.new(params[:nauczyciel])
    @nauczyciel.set_editors_stamp get_editors_stamp
    @nauczyciel.set_current_user current_user


    respond_to do |format|
      if @nauczyciel.save
        flash[:notice] = 'Nauczyciel was successfully created.'
        @nauczyciel.zarzadzaj_grupa params[:new_nauczyciel], params[:existing_nauczyciel], get_editors_stamp, current_user
        format.html { redirect_to nauczyciele_path }
        format.xml  { render :xml => @nauczyciel, :status => :created, :location => @nauczyciel }
      else
        format.html { render :action => "new", :layout => "application" }
        format.xml  { render :xml => @nauczyciel.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @nauczyciel = Nauczyciel.find(params[:id])
    @nauczyciel.set_editors_stamp get_editors_stamp
    @nauczyciel.set_current_user current_user
    
    respond_to do |format|
      if @nauczyciel.update_attributes(params[:nauczyciel])
        @nauczyciel.zarzadzaj_grupa params[:new_nauczyciel], params[:existing_nauczyciel], get_editors_stamp, current_user
        flash[:notice] = 'Nauczyciel was successfully updated.'
        format.html { redirect_to nauczyciele_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => "application" }
        format.xml  { render :xml => @nauczyciel.errors, :status => :unprocessable_entity }
      end
    end
  end


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
      format.html { redirect_to nauczyciele_path }
      format.xml  { head :ok }
    end
  end
  

   def konta
    pdf = PDF::Writer.new
    pdf.select_font "Courier"
 
    j= true
    
    for i in (params["konto"].nil?) ? [] : params["konto"].keys
      
      pdf.start_new_page unless j
      j = false
      
      n = Nauczyciel.find i.to_i
      us= User.new :login => n.pesel
      haslo = n.new_key
      us.password = haslo
      us.nauczyciel_id = n.id
      us.save(false)
      us.register!
      us.activate!
      
      y0 = pdf.y + 18
      y0 = pdf.y + 18
      pdf.stroke_color  Color::RGB::Navy
      pdf.rounded_rectangle(pdf.left_margin + 25, y0-15, pdf.margin_width-50,y0 - pdf.y + 18, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-65, pdf.margin_width-100, y0 - pdf.y + 70, 10).stroke
      
      pdf.text "<b>TWORZENIE KONTA</b>", :font_size => 20, :justification => :center
      pdf.text "Utworzone zostalo nowe konto dla nauczyciela: ", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << n.imie << " " << n.nazwisko, :font_size => 12, :justification => :center
     pdf.text "</b>Dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << n.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120
    end
    
    for i in (params["haslo"].nil?) ? [] : params["haslo"].keys
      
      pdf.start_new_page unless j
      j = false
      
      n = Nauczyciel.find i.to_i
      us= n.user
      haslo = n.new_key
      us.password = haslo
      us.save(false)

      y0 = pdf.y + 18
      pdf.stroke_color  Color::RGB::Navy
      pdf.rounded_rectangle(pdf.left_margin + 25, y0-15, pdf.margin_width-50,y0 - pdf.y + 18, 10).stroke
      pdf.rounded_rectangle(pdf.left_margin + 50, y0-65, pdf.margin_width-100, y0 - pdf.y + 70, 10).stroke

      pdf.text "<b>ZMIANA HASLA</b>", :font_size => 20, :justification => :center
      pdf.text "Utworzone zostalo nowe haslo dla nauczyciela:", :font_size => 12, :spacing => 3, :justification => :center
      pdf.text "<b>" << n.imie << " " << n.nazwisko, :font_size => 12, :justification => :center

      pdf.text "</b>Nowe dane do logowania:", :leading => 24, :left =>110
      pdf.text "<b>Login:</b> " << n.pesel, :left => 120, :leading => 18
      pdf.text "<b>Haslo:</b> " << haslo, :left => 120

    end
     
    send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline' unless params["haslo"].nil? & params["konto"].nil?
    redirect_to :action => :index unless !(params["haslo"].nil? & params["konto"].nil?)
  end
end