class Grupa < ActiveRecord::Base
  has_many :czlonkowie
  has_many :listy
  has_many :uczniowie, :through => :czlonkowie  ##
  has_many :grupy
  belongs_to :nauczyciel
  belongs_to :grupa 
  
  acts_as_external_archive

  named_scope :existing , :conditions => ["destroyed = ?", false]
  named_scope :destroyed, :conditions => ["destroyed = ?", true]

  def zarzadzaj_grupa kandydaci, czlonkowie
    all = Czlonek.existing.find(:all, :conditions => ["grupa_id = ?", self.id])
      
    all.each do |key|
        key.destroy unless !(czlonkowie[key.uczen_id.to_s]).nil?
    end
    
    for key in (kandydaci.nil?) ? {} : kandydaci.keys
      c = Czlonek.new
      c.uczen_id = key.to_i
      c.grupa_id = self.id
      c.save
    end
  end

end
