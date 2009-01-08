class RodzicController < ApplicationController
  
  
  def intro
    
  end
  
  def plan
    @tydzien = Date.today.at_beginning_of_week
    plan_id = []
    for i in 0..6
      plan_id += [Plan.aktualny @tydzien + i.days]
    end

    @grupy   = Grupa.existing.find(:all, :include => :czlonkowie, :conditions => ["czlonkowie.destroyed = ? AND czlonkowie.uczen_id = ?", false, current_user.rodzic.uczniowie.first.id])
    
    @godziny = Godzina.existing.sort_by{|s| s.begin}
    
    @plan = Create_Array [@godziny.size, 7]
    doklej = scope_or("listy.grupa_id", @grupy.collect{|c| c.id})
    
    i = 0
    for i in 0...@godziny.size
      for j in 0...7
        @plan[i][j] = Lekcja.existing.find(:all, :include => :lista, :conditions => ["listy.destroyed = ? AND godzina_id = ? AND plan_id = ? AND dzien_tygodnia =? AND " << doklej , false, @godziny[i].id, plan_id[j], j+1 ])
      end
    end
    

    render :layout => "application"
  end

  def oceny
  end

  def obecnosci
  end

  def przedmioty
  end





end
