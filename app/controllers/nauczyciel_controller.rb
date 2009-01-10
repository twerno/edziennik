class NauczycielController < ApplicationController
  before_filter :nauczyciel_rights
  
  def intro
    
  end

  def plan
    begin
      @tydzien = params[:date].to_date.at_beginning_of_week
    rescue
      @tydzien = Date.today.at_beginning_of_week
    end
    
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ? AND nauczyciel_id = ?"  , false, @godziny[i].id, plan_id[j], j+1, current_user.nauczyciel.id ])
      end
    end
    

    render :layout => "application" unless params[:layout].nil?
  end

  def dziennik
    #begin
      @nauczyciel = current_user.nauczyciel
      @date   = params[:date].to_date
      @lekcja = Lekcja.existing.find(:first, :conditions => ["id = ? AND dzien_tygodnia = ?", params[:lekcja], @date.cwday])
      @lista  = @lekcja.lista
      @rubryki = @lista.rubryki
      @przedmiot = @lekcja.przedmiot
      @listy = @nauczyciel.listy
      @uczniowie = Uczen.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.grupa_id = ? AND czlonkowie.destroyed = ?", @lekcja.lista.grupa.id, false], :order => :nazwisko)
      render :layout => "application" unless params[:layout].nil?
    #rescue
    #  render :text => "wystąpił błąd", :layout => "application"
    #end
  end


  def sprawdzam_obecnosc
    o = Obecnosc.find(:first, :conditions => ["uczen_id = ? AND lekcja_id = ?", params[:uczen].to_i, params[:lekcja].to_i])
    if o.nil?
      o = Obecnosc.new :wartosc => params[:wartosc], :uczen_id => params[:uczen], :lekcja_id => params[:lekcja], :lista_id => params[:lista], :data => params[:date].to_date
    elsif o.wartosc != params[:wartosc]
      o.wartosc = params[:wartosc]
    end
    o.set_editors_stamp get_editors_stamp
    o.set_current_user  current_user
    if o.save
      @wartosc = params[:wartosc].to_i
      respond_to do |format|
        format.js
      end  
    end
  end

  def wybierz_rubryke
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def ocen_ucznia
    ocena = Ocena.find(:first, :conditions => ["rubryka_id = ? AND uczen_id = ?", params[:Ocena][:rubryka_id].to_i, params[:Ocena][:uczen_id].to_i])
    if ocena.nil?
      ocena = Ocena.new params[:Ocena]
    end  
    ocena.nauczyciel_id = current_user.nauczyciel.id
    ocena.set_editors_stamp get_editors_stamp
    ocena.set_current_user  current_user
    if ocena.save
      respond_to do |format|
        format.js
      end  
    end
  end
end
