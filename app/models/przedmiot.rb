class Przedmiot < ActiveRecord::Base
  has_many :pnjts
  has_many :nauczyciele, :through => :pnjts
  has_many :oceny,       :through => :listy
  has_many :obecnosci,   :through => :listy
  has_many :listy
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["przedmioty.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["przedmioty.destroyed = ?", true]
end
