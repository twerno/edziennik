class Ocena < ActiveRecord::Base
  belongs_to :uczen
  belongs_to :nauczyciel
  belongs_to :lista
  belongs_to :lekcja
#  belongs_to :przedmiot, :through => :listy
  
  named_scope :existing ,   :conditions => ["ocena.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["ocena.destroyed = ?", true]  
  acts_as_external_archive
end
