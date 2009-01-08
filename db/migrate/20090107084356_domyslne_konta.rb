class DomyslneKonta < ActiveRecord::Migration
  def self.up
    u = Uczen.new :imie => "uczen", :nazwisko => "uczen", :pesel => "uczen", :nr_legitymacji => "uczen"
    r = Rodzic.new :imie_ojca => "rodzic", :imie_matki => "rodzic", :pesel => "rodzic", :nazwisko => "uczen", :nazwisko_panienskie => "rodzic"
    r.save
    u.rodzic_id = r.id
    u.save
    
    n = Nauczyciel.new :imie => "nauczyciel", :nazwisko => "nauczyciel", :pesel => "nauczyciel"
    n.save
    
    us = User.new
    us.login = "uczen"
    us.password = "uczen"
    us.uczen_id = u.id
    us.save(false)
    us.register!
    us.activate!
    
    us = User.new
    us.login = "rodzic"
    us.password = "rodzic"
    us.rodzic_id = r.id
    us.save(false)
    us.register!
    us.activate!
    
    us = User.new
    us.login = "nauczyciel"
    us.password = "nauczyciel"
    us.nauczyciel_id = n.id
    us.save(false)
    us.register!
    us.activate!

  end

  def self.down
  end
end
