class UtworzeniePrzedmiotow < ActiveRecord::Migration
  def self.up
    p = Przedmiot.new :nazwa => "Historia"
    p.save
    p = Przedmiot.new :nazwa => "Biologia"
    p.save
    p = Przedmiot.new :nazwa => "Matematyka"
    p.save
    p = Przedmiot.new :nazwa => "Geografia"
    p.save
    p = Przedmiot.new :nazwa => "j. Polski"
    p.save
    p = Przedmiot.new :nazwa => "j. Angielski"
    p.save
    p = Przedmiot.new :nazwa => "Muzyka"
    p.save
    p = Przedmiot.new :nazwa => "Religia"
    p.save
    p = Przedmiot.new :nazwa => "Fizyka"
    p.save
    p = Przedmiot.new :nazwa => "Plastyka"
    p.save
    p = Przedmiot.new :nazwa => "Sztuka"
    p.save
    p = Przedmiot.new :nazwa => "Wf"
    p.save
    p = Przedmiot.new :nazwa => "Chemia"
    p.save
    p = Przedmiot.new :nazwa => "Wiedza o społeczeństiwe"
    p.save
    p = Przedmiot.new :nazwa => "Informatyka"
    p.save
  end

  def self.down
  end
end
