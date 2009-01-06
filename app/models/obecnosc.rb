class Obecnosc < ActiveRecord::Base
  belongs_to :lista
  belongs_to :uczen
  belongs_to :lekcja
  has_one    :przedmiot, :through => :listy
  
  
  named_scope :existing ,   :conditions => ["obecnosci.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["obecnosci.destroyed = ?", true]
  acts_as_external_archive
end
