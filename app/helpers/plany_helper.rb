module PlanyHelper
  
  def nazwa_przedmiotu plan_id, dzien_tygodnia, godzina, grupa_id
    l = Lekcja.existing.find(:first, :include => :lista, :conditions => ["plan_id = ? AND dzien_tygodnia = ? AND godzina_id = ? AND listy.grupa_id = ? AND listy.destroyed = ?", plan_id, dzien_tygodnia, godzina, grupa_id, false])
    (l.nil?) ? '&nbsp;' : h(l.przedmiot.nazwa)
  end
  
  
  def onclick_to_remote(options = {})
    *args = remote_function(options)
    function = args[0] || ''
    function = update_page(&block) if block_given?
    "onclick=\"#{function}; return false;\""
  end
end
