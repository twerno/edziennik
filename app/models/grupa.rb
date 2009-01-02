class Grupa < ActiveRecord::Base
  has_many :czlonkowie
  has_many :listy
  has_many :uczniowie, :through => :czlonkowie  ##
  has_many :grupy
  belongs_to :nauczyciel
  belongs_to :grupa 
  
  acts_as_external_archive

  named_scope :existing ,   :conditions => ["destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["destroyed = ?", true]
  
  named_scope :klasa,       :conditions => ["klasa = ?", true]
  named_scope :grupy,       :conditions => ["klasa = ?", false]
  named_scope :grupy_klasy, lambda { |*args| {:conditions => ["klasa = ? AND grupa_id = ?", true, args[0].to_i]}}
  

  def zarzadzaj_grupa kandydaci, czlonkowie, editors_stamp, current_user
    all = Czlonek.existing.find(:all, :conditions => ["grupa_id = ?", self.id])
    
    czlonkowie = (czlonkowie.nil?) ? {} : czlonkowie
    
    all.each do |key|
      key.set_editors_stamp editors_stamp unless !(czlonkowie[key.uczen_id.to_s]).nil?
      key.set_current_user                unless !(czlonkowie[key.uczen_id.to_s]).nil?
      key.destroy                         unless !(czlonkowie[key.uczen_id.to_s]).nil?
    end
    
    
    for key in (kandydaci.nil? || kandydaci.empty?) ? {} : kandydaci.keys
      c = Czlonek.new
      c.uczen_id = key.to_i
      c.grupa_id = self.id
      c.set_editors_stamp editors_stamp
      c.set_current_user current_user      
      c.save
    end
  end

end
