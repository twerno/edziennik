class UtworzeniePrzedmiotow < ActiveRecord::Migration
  def self.up
    p = Przedmiot.new :nazwa => "Historia"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Biologia"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Matematyka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Geografia"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "j. Polski"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "j. Angielski"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Muzyka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Religia"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Fizyka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Plastyka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Sztuka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Wf"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Chemia"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Wiedza o społeczeństiwe"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
    p = Przedmiot.new :nazwa => "Informatyka"
    p.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    p.save
  end

  def self.down
  end
end
