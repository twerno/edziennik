class NauczycielController < ApplicationController
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

    #@grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.rodzic.uczniowie.first.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    #@obecnosci = Create_Array [@godziny.size, 7]
    #doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    #doklej = (!doklej.empty?) ? " AND " << doklej : ""
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ? AND nauczyciel_id = ?"  , false, @godziny[i].id, plan_id[j], j+1, current_user.nauczyciel.id ])
        #@obecnosci[i][j] = (!@plan[i][j].empty?) ? @plan[i][j][0].obecnosci.find_by_uczen_id( current_user.rodzic.uczniowie.first.id) : nil
      end
    end
    

    render :layout => "application" unless params[:layout].nil?
  end

  def dziennik
    begin
      @date   = params[:date].to_date
      @lekcja = Lekcja.existing.find(:first, :conditions => ["id = ? AND dzien_tygodnia = ?", params[:lekcja], @date.cwday])
      @lista  = @lekcja.lista
      @rubryki = @lista.rubryki
      @przedmiot = @lekcja.przedmiot
      @uczniowie = Uczen.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.grupa_id = ? AND czlonkowie.destroyed = ?", @lekcja.lista.grupa.id, false], :order => :nazwisko)
      render :layout => "application" unless params[:layout].nil?
    rescue
      render :text => "wystąpił błąd", :layout => "application"
    end
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
end
