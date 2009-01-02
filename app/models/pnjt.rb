class Pnjt < ActiveRecord::Base
  belongs_to :nauczyciel
  belongs_to :przedmiot
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["destroyed = ?", true]
end
