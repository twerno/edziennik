class Nauczyciel < ActiveRecord::Base
  belongs_to :user
  has_one    :grupa  #wychowawca
  has_many   :pnjts  #PRZEDMIOT-NAUCZYCIEL JOIN MODEL
  has_many   :przedmioty, :through => :pnjts
  has_many   :oceny
  has_many   :listy

  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["destroyed = ?", true]
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
end
