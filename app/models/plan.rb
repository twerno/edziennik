class Plan < ActiveRecord::Base
  belongs_to :semestr
  has_many   :lekcje
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["plany.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["plany.destroyed = ?", true]
  
  named_scope :active,   :conditions => ["active = ?", true]
end
