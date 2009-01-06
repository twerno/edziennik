class DziennikiController < ApplicationController
  def plan
    queries = queries_parameters params[:parametry]
    
    @godziny = Godzina.existing.find(:all, :order => :begin)
    @user = 1
        
    begin
      @poniedzialek = queries["data"].to_date.at_beginning_of_week
    rescue
      @poniedzialek = Date.today.at_beginning_of_week
    end
    
 
  end
  
  def show
    queries = queries_parameters params[:parametry]

    @przedmiot = Przedmiot.existing.find(:first, :include => :listy, :conditions => ["listy.destroyed = ? AND listy.przedmiot_id = ? AND listy.grupa_id = ? AND listy.semestr_id = ?", false, queries["przedmiot"], queries["klasa"], queries["semestr"]])
    @klasa     = Grupa.existing.find_by_id queries["klasa"]

    begin
      @poniedzialek = queries["data"].to_date.at_beginning_of_week
    rescue
      @poniedzialek = Date.today.at_beginning_of_week
    end
    
    @uczniowie = Uczen.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.grupa_id = ? AND czlonkowie.destroyed = ?", @klasa.id, false], :order => :nazwisko).sort_by{|s| s.nazwisko.to_s.upcase+" "+s.imie.to_s.upcase}
    
    if (@przedmiot.nil? || @uczniowie.nil?)
      render( :text => "Wystąpił błąd")
    end
  end
  
  
  def sprawdz_obecnosc
    @queries = queries_parameters params[:parametry]
    
    #puts params[:parametry]
    #puts @queries["data"]
    #puts @queries
    
    @lekcja    = Lekcja.find @queries["lekcja"]
    @data      = @queries["data"].to_date
    @uczniowie = Grupa.existing.find_by_id( @queries["grupa"]).uczniowie.existing.uniq
    
    @parametry = params[:parametry]
  end
  
  
  def obecnosc_create
    @queries = queries_parameters params[:parametry]
    
    params["obecnosci"].each_key do |key|
      u = Uczen.find_by_id key.to_i
      o = u.obecnosci.find_by_data @queries["data"].to_date
      if o.nil? || o.wartosc.to_s != params["obecnosci"][key]
        o = u.obecnosci.build( :lekcja_id => @queries["lekcja"].to_i, :uczen_id => key.to_i, :data => @queries["data"]) unless !o.nil?
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




