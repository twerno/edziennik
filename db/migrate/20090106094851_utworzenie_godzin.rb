class UtworzenieGodzin < ActiveRecord::Migration
  def self.up
    g = Godzina.new :begin => "8:00", :end => "8:45", :nazwa => "1"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "9:00", :end => "9:45", :nazwa => "2"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "10:00", :end => "10:45", :nazwa => "3"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "11:00", :end => "11:45", :nazwa => "4"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "12:00", :end => "12:45", :nazwa => "5"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "13:00", :end => "13:45", :nazwa => "6"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "14:00", :end => "14:45", :nazwa => "7"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "15:00", :end => "15:45", :nazwa => "8"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "16:00", :end => "16:45", :nazwa => "9"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "17:00", :end => "17:45", :nazwa => "10"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "18:00", :end => "18:45", :nazwa => "11"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "19:00", :end => "19:45", :nazwa => "12"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
    g = Godzina.new :begin => "20:00", :end => "20:45", :nazwa => "13"
    g.set_editors_stamp ({:editors_browser => "db:migrate", :editors_ip => "127.0.0.1", :current_user => "1"})
    g.save
  end

  def self.down
  end
end
