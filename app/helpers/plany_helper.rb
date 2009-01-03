module PlanyHelper
  
  def nazwa_przedmiotu plan_id, dzien_tygodnia, godzina, grupa_id
    l = Lekcja.existing.find(:first, :conditions => ["plan_id = ? AND dzien_tygodnia = ? AND godzina_id = ?", plan_id, dzien_tygodnia, godzina])
    g = (l.nil?) ? [] : l.listy.existing.find_by_grupa_id(grupa_id)
    p = (g == [] || g.nil?) ? "..." : g.przedmiot.nazwa
    p
  end
end
