class Nauczyciel < ActiveRecord::Base
  belongs_to :user
  #has_one  :user, :as => :polymorph
  has_one    :grupa  #wychowawca
  has_many   :pnjts     , :dependent => :destroy  #PRZEDMIOT-NAUCZYCIEL JOIN MODEL
  has_many   :przedmioty, :through => :pnjts
  has_many   :oceny
  has_many   :listy

  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["nauczyciele.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["nauczyciele.destroyed = ?", true]
  named_scope :order_by_nazwisko, :order => :nazwisko
  
  def wychowawca?
    ((Grupa.existing.klasa.find_by_nauczyciel_id self.id).nil?) ? false : true
  end
  
  def self.nie_wychowawca
    nie_wychowawcy = []
    Nauczyciel.existing.order_by_nazwisko.each do |nauczyciel|
      nie_wychowawcy += [nauczyciel] unless !nauczyciel.grupa.nil?
    end
    nie_wychowawcy
  end
  
  def utworz_konto
    if self.user.nil?
      user            = self.build_user
      user.login      = user.new_random_password self.imie
      user.password   = user.new_random_password self.nazwisko
      #user.class_name =  
      wrk1 = user.register!
      if wrk1
        @user.activate!
      end
      
    end
  end
  
  
  def zarzadzaj_grupa kandydaci, czlonkowie, editors_stamp, current_user
    all = Pnjt.existing.find(:all, :conditions => ["nauczyciel_id = ?", self.id])

    czlonkowie = (czlonkowie.nil?) ? {} : czlonkowie

    all.each do |key|
        key.set_editors_stamp editors_stamp unless !(czlonkowie[key.przedmiot_id.to_s]).nil?
        key.set_current_user current_user unless !(czlonkowie[key.przedmiot_id.to_s]).nil?
        key.destroy unless !(czlonkowie[key.przedmiot_id.to_s]).nil?
    end 


    for key in (kandydaci.nil? || kandydaci.empty?) ? {} : kandydaci.keys
      c = Pnjt.new :przedmiot_id => key.to_i, :nauczyciel_id => self.id
      c.set_editors_stamp editors_stamp
      c.set_current_user current_user
      c.save
    end
  end
  
end
