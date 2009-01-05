class DziennikiController < ApplicationController
  def plan
    @godziny = Godzina.existing.find(:all, :order => :begin)
    @user    = 1 
  end
  
  def show
    queries = queries_parameters params[:parametry]

    @przedmiot = Przedmiot.existing.find(:first, :include => :listy, :conditions => ["listy.destroyed = ? AND listy.przedmiot_id = ? AND listy.grupa_id = ? AND listy.semestr_id = ?", false, queries["przedmiot"], queries["klasa"], queries["semestr"]])
    @klasa     = Grupa.existing.find_by_id queries["klasa"]
    
    @uczniowie = Uczen.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.grupa_id = ? AND czlonkowie.destroyed = ?", @klasa.id, false], :order => :nazwisko).sort_by{|s| s.nazwisko.to_s.upcase+" "+s.imie.to_s.upcase}
    
    if (@przedmiot.nil? || @uczniowie.nil?)
      render (:text => "Wystąpił błąd")
    end
  end
end
