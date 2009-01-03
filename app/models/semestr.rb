class Semestr < ActiveRecord::Base
  has_many :listy
  has_many :plany
  
  acts_as_external_archive

  named_scope :existing ,   :conditions => ["destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["destroyed = ?", true]
end
