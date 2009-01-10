class Grupa < ActiveRecord::Base
  has_many :czlonkowie
  has_many :listy
  has_many :uczniowie, :through => :czlonkowie  ##
  has_many :grupy
  belongs_to :nauczyciel
  belongs_to :grupa 
  
  acts_as_external_archive

  named_scope :existing ,   :conditions => ["grupy.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["grupy.destroyed = ?", true]
  
  named_scope :klasa,       :conditions => ["klasa = ?", true]
  named_scope :grupy,       :conditions => ["klasa = ?", false]
  named_scope :grupy_klasy, lambda { |*args| {:conditions => ["klasa = ? AND grupa_id = ?", true, args[0].to_i]}}
  

  validates_presence_of :nazwa

  @@editors_stamp = ""
  @@user = ""
  
  def set editors_stamp, user
    @@editors_stamp = editors_stamp
    @@user = user
  end

  def zarzadzaj_grupa kandydaci, czlonkowie, editors_stamp, current_user
    all = Czlonek.existing.find(:all, :conditions => ["grupa_id = ?", self.id])
    
    czlonkowie = (czlonkowie.nil?) ? {} : czlonkowie
    
    all.each do |key|
      (key.set_editors_stamp editors_stamp #unless !(czlonkowie[key.uczen_id.to_s]).nil?
      key.set_current_user current_user               #unless !(czlonkowie[key.uczen_id.to_s]).nil?
      key.destroy          )               unless !(czlonkowie[key.uczen_id.to_s]).nil?
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
  
  after_update :save_listy


  def existing_lista_attributes=(lista_attributes)
    listy.reject(&:new_record?).each do |lista|
      attributes = lista_attributes[lista.id.to_s]
      if attributes
        lista.attributes = attributes
      else
        lista.set_editors_stamp @@editors_stamp
        lista.set_current_user @@user
        lista.rubryki.destroy_all
        lista.destroy
      end
    end
    save_listy
  end
  
  #def listy
  # (Lista.existing.find_all_by_grupa_id(self.id).empty?) ? self : Lista.existing.find_all_by_grupa_id(self.id)
   #self.super(listy)
  #end
  
  def new_lista_attributes=(lista_attributes)
    lista_attributes.each do |attributes|
       l = listy.build(attributes)
       #puts l.id
       #puts l.class.name
       #sputs Archive.find(:last, :conditions=>["class_name = ?", l.class.name]).id
       #puts Archive.find(:last, :conditions=["class_id = ? AND class_name = ?", l.id, l.class.name])
       #a.set_editors_stamp @@editors_stamp
       #a.set_current_user @@user
       #a.save
    end
  end
  
  def save_listy
    listy.each do |lista|
      lista.set_editors_stamp @@editors_stamp
      lista.set_current_user @@user
      new_rec = lista.new_record?
      lista.save
      if new_rec
        i = 0
        10.times {
        i += 1
        lista.rubryki.create :opis => i.to_s
        }
       end 
    end
  end

end
