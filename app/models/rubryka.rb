class Rubryka < ActiveRecord::Base
  belongs_to :lista
  has_many   :oceny

  named_scope :existing ,   :conditions => ["nauczyciele.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["nauczyciele.destroyed = ?", true]  
  
  acts_as_external_archive
end
