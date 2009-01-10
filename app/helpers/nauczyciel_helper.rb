module NauczycielHelper
  
  def obecny uczen, lekcja
    l = lekcja.obecnosci.find_by_uczen_id uczen.id
    if !l.nil? && (l.wartosc == 1 || l.wartosc == 4)
       return " style='display:block' "
    end    
  end
  
   def nieobecny uczen, lekcja
    l = lekcja.obecnosci.find_by_uczen_id uczen.id
    if !l.nil? && l.wartosc == 2
       return " style='display:block' "
    end    
  end 
  
  
  def spozniony uczen, lekcja
    l = lekcja.obecnosci.find_by_uczen_id uczen.id
    if !l.nil? && l.wartosc == 3
       return " style='display:block' "
    end    
  end
  
  def onclick_to_remote(options = {})
    *args = remote_function(options)
    function = args[0] || ''
    function = update_page(&block) if block_given?
    "onclick=\"#{function}; return false;\""
  end
  
  def ocena rubryka, uczen
    o = rubryka.oceny.find_by_uczen_id uczen
    (o.nil?) ? '' : o.wartosc_oceny 
  end  
end