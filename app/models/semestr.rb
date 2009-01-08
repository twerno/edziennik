class Semestr < ActiveRecord::Base
  has_many :listy
  has_many :plany
  
  acts_as_external_archive

  named_scope :existing ,   :conditions => ["semestry.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["semestry.destroyed = ?", true]
  
  named_scope :active,   :conditions => ["semestry.aktualny = ?", true]
  
  validates_presence_of :nazwa  
end
