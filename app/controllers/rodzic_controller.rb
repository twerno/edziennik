class RodzicController < ApplicationController

  def intro
    @tydzien = Date.today.at_beginning_of_week
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.rodzic.uczniowie.first.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    @obecnosci = Create_Array [@godziny.size, 7]
    doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    doklej = (!doklej.empty?) ? " AND " << doklej : ""    
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ?" << doklej , false, @godziny[i].id, plan_id[j], j+1 ])
        @obecnosci[i][j] = (!@plan[i][j].empty?) ? @plan[i][j][0].obecnosci.find_by_uczen_id( current_user.rodzic.uczniowie.first.id) : nil
      end
    end    
  end
  
  def plan
    @tydzien = Date.today.at_beginning_of_week
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.rodzic.uczniowie.first.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan      = Create_Array [@godziny.size, 7]
    @obecnosci = Create_Array [@godziny.size, 7]
    doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    doklej = (!doklej.empty?) ? " AND " << doklej : ""
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia = ? " << doklej , false, @godziny[i].id, plan_id[j], j+1 ])
        @obecnosci[i][j] = (!@plan[i][j].empty?) ? @plan[i][j][0].obecnosci.find_by_uczen_id( current_user.rodzic.uczniowie.first.id) : nil
      end
    end
    

    render :layout => "application"
  end

  def oceny
  end

  def obecnosci
  end

  def przedmioty
    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.rodzic.uczniowie.first.id])
    @listy = Lista.existing.find(:all, :conditions => [scope_or("listy.grupa_id", @grupy.collect{|c| c.id})])
  end

  def przedmiot
    @lista        = Lista.find params[:id]
    @oceny        = current_user.rodzic.uczniowie.first.oceny.find_by_lista_id params[:id]
    @oceny        = (@oceny.nil?) ? [] : @oceny
    @srednia      = 0
    @oceny.each{|o| @srednia += o.wartosc }
    @srednia     /= (@oceny.size != 0) ? @oceny.size : 1               
    @obecnosci    = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.rodzic.uczniowie.first.id, params[:id], 1])
    @nieobecnosci = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.rodzic.uczniowie.first.id, params[:id], 2], :order => :data)
    @spoznienia   = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.rodzic.uczniowie.first.id, params[:id], 3])
    @zwolnienia   = Obecnosc.find(:all, :conditions => ["uczen_id = ? AND lista_id = ? AND wartosc = ?", current_user.rodzic.uczniowie.first.id, params[:id], 4])
    @wszystkich   = Obecnosc.count(     :conditions => ["uczen_id = ? AND lista_id = ?",                 current_user.rodzic.uczniowie.first.id, params[:id]   ])
    render :layout => "application"
  end

end
