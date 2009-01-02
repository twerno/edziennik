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
  

  def zarzadzaj_grupa kandydaci, czlonkowie
    all = Czlonek.existing.find(:all, :conditions => ["grupa_id = ?", self.id])
      
    all.each do |key|
        key.destroy unless !(czlonkowie[key.uczen_id.to_s]).nil?
    end unless czlonkowie.nil? || czlonkowie.empty?
    
    
    for key in (kandydaci.nil? || kandydaci.empty?) ? {} : kandydaci.keys
      c = Czlonek.new
      c.uczen_id = key.to_i
      c.grupa_id = self.id
      c.save
    end
  end

end
