class UczenController < ApplicationController

  def intro
    begin
      @tydzien = params[:date].to_date.at_beginning_of_week
    rescue
      @tydzien = Date.today.at_beginning_of_week
    end
    
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.uczen.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    @obecnosci = Create_Array [@godziny.size, 7]
    doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    doklej = (!doklej.empty?) ? " AND " << doklej : ""
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ?" << doklej , false, @godziny[i].id, plan_id[j], j+1 ])
        @obecnosci[i][j] = (!@plan[i][j].empty?) ? @plan[i][j][0].obecnosci.find_by_uczen_id( current_user.uczen.id) : nil
      end
    end    
  end
  
  def plan
    @tydzien = Date.today.at_beginning_of_week
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.uczen.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    @obecnosci = Create_Array [@godziny.size, 7]
    doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    doklej = (!doklej.empty?) ? " AND " << doklej : ""
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ?" << doklej , false, @godziny[i].id, plan_id[j], j+1 ])
        @obecnosci[i][j] = (!@plan[i][j].empty?) ? @plan[i][j][0].obecnosci.find_by_uczen_id( current_user.uczen.id) : nil
      end
    end
    

    render :layout => "application" unless params[:layout].nil?
  end

  def oceny
  end

  def obecnosci
  end

  def przedmioty
    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.uczen.id])
    @listy = Lista.existing.find(:all, :conditions => [scope_or("listy.grupa_id", @grupy.collect{|c| c.id})])
  end

  def przedmiot
    @lista        = Lista.find params[:id]
    @oceny        = current_user.uczen.oceny.find_by_lista_id params[:id]
    @oceny        = (@oceny.nil?) ? [] : @oceny
    @srednia      = srednia @oceny               
    @obecnosci    = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.uczen.id, params[:id], 1])
    @nieobecnosci = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.uczen.id, params[:id], 2], :order => :data)
    @spoznienia   = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.uczen.id, params[:id], 3])
    @zwolnienia   = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.uczen.id, params[:id], 4])
    @wszystkich   = Obecnosc.count(     :conditions => ["uczen_id = ? AND lista_id = ?",                 current_user.uczen.id, params[:id]   ])
    render :layout => "application"
  end

  private
  def srednia oceny
    wynik = 0
    if oceny.size != 0
      for o in oceny
        wynik += o.wartosc_oceny
      end
      wynik = wynik.to_f/oceny.size
    end
    wynik
  end
  
  
end
