class Grupa < ActiveRecord::Base
  has_many :czlonkowie
  has_many :listy
  has_many :uczniowie, :through => :czlonkowie  ##
  has_many :grupy
  belongs_to :nauczyciel
  belongs_to :grupa
  
  
  
  acts_as_external_archive

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

  
 # def new_czlonek_attributes=(new_czlonek)
 #   puts "AAAAAAAAAAAAAAAaaa"
 # end
#  after_update :save_czlonkowie
#
#  
#  def new_czlonek_attributes=(czlonek_attributes)
#    czlonek_attributes.each do |attributes|
#      czlonkowie.build(attributes)
#    end
#  end
#  
#  
#  def existing_czlonek_attributes=(czlonek_attributes)
#    czlonkowie.reject(&:new_record?).each do |czlonek|
#      attributes = czlonek_attributes[czlonek.id.to_s]
#      if attributes
#        czlonek.attributes = attributes
#      else
#        czlonkowie.delete(czlonek)
#      end
#    end
#  end
#  
#  def save_czlonkowie
#    czlonkowie.each do |czlonek|
#      czlonek.save(false)
#    end
#  end


end
