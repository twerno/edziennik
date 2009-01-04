module PlanyHelper
  
  def nazwa_przedmiotu plan_id, dzien_tygodnia, godzina, grupa_id
    l = Lekcja.existing.find(:first, :include => :lista, :conditions => ["plan_id = ? AND dzien_tygodnia = ? AND godzina_id = ? AND listy.grupa_id = ?", plan_id, dzien_tygodnia, godzina, grupa_id])
    (l.nil?) ? dzien_tygodnia.to_s+" "+godzina.to_s : l.przedmiot.nazwa
  end
end
