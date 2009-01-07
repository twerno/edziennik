class DziennikiController < ApplicationController
  def plan
    queries = queries_parameters params[:parametry]
    
    @godziny = Godzina.existing.find(:all, :order => :begin)
    @nauczyciel = zalogowany
    
    #lekcje = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND listy.nauczyciel_id = ? AND listy.semestr_id = ?", false, @nauczyciel.id, 1] )
    
    @nazwy_wierszy = []
    @nazwy_kolumn  = []
    
    @lekcje = []
    i = 0
    for godz in Godzina.existing
      @nazwy_wierszy += [godz.begin.strftime("%H") << ":" << godz.begin.strftime("%M") << "-" << godz.end.strftime("%H") << ":" << godz.end.strftime("%M")]
      @lekcje += [[[]]]
      for j in 1..7
        #@lekcje[i]   += [[nil]]
        #puts j
        @lekcje[i] += [Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND listy.nauczyciel_id = ? AND listy.semestr_id = ? AND lekcje.godzina_id = ? AND lekcje.dzien_tygodnia = ?", false, @nauczyciel.id, 1, godz.id, j] ).to_a]
      end
      i += 1
    end
    
    begin
      @poniedzialek = queries["data"].to_date.at_beginning_of_week
    rescue
      @poniedzialek = Date.today.at_beginning_of_week
    end
    
 
  end
  
  def show
    @queries = queries_parameters params[:parametry]

    @przedmiot = Przedmiot.existing.find(:first, :include => :lekcje, :conditions => ["lekcje.id = ? ", @queries["lekcja"]])
    @klasa     = Grupa.existing.find_by_id @queries["klasa"]
    @lista     = Lekcja.find(@queries["lekcja"].to_i).lista_id
    
    begin
      @poniedzialek = @queries["data"].to_date.at_beginning_of_week
    rescue
      @poniedzialek = Date.today.at_beginning_of_week
    end
    
    @uczniowie = Uczen.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.grupa_id = ? AND czlonkowie.destroyed = ?", @klasa.id, false], :order => :nazwisko)
    
    if (@przedmiot.nil? || @uczniowie.nil?)
      render( :text => "Wystąpił błąd")
    end
    render :layout => "application"
  end
  
  
  def sprawdz_obecnosc
    @queries = queries_parameters params[:parametry]
    
    @lekcja    = Lekcja.find @queries["lekcja"]
    @data      = @queries["data"].to_date
    @uczniowie = Grupa.existing.find_by_id( @queries["grupa"]).uczniowie.existing.uniq
    
    @parametry = params[:parametry]
  end
  
  
  def obecnosc_create
    @queries = queries_parameters params[:parametry]
    
    params["obecnosci"].each_key do |key|
      u = Uczen.find_by_id key.to_i
      o = u.obecnosci.find(:first, :conditions => ["data = ? AND lekcja_id = ? AND uczen_id = ?", @queries["data"], @queries["lekcja"], key.to_i])
      if o.nil? || o.wartosc.to_s != params["obecnosci"][key]
        o = u.obecnosci.build( :lekcja_id => @queries["lekcja"].to_i, :uczen_id => key.to_i, :data => @queries["data"], :lista_id => Lekcja.find_by_id(@queries["lekcja"].to_i).lista_id ) unless !o.nil?
        o.set_editors_stamp get_editors_stamp
        o.set_current_user  current_user
        o.wartosc = params["obecnosci"][key].to_i
        o.save
      end
    end
    #uczen.obecnosci.find_by_data @queries["data"]
    redirect_to obecnosc_url (:parametry => params[:parametry])
  end
  
end




