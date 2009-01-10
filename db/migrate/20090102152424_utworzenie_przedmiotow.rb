class UtworzeniePrzedmiotow < ActiveRecord::Migration
  def self.up
    u = User.new :id => 1
    p = Przedmiot.new :nazwa => "Historia"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Biologia"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Matematyka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Geografia"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "j. Polski"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "j. Angielski"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Muzyka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Religia"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Fizyka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Plastyka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Sztuka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Wf"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Chemia"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Wiedza o społeczeństiwe"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
    p = Przedmiot.new :nazwa => "Informatyka"
    p.set_editors_stamp "db:migrate"
    p.set_current_user u
    p.save
  end

  def self.down
  end
end
