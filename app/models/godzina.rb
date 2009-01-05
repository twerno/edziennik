class Godzina < ActiveRecord::Base
  has_many :lekcje
  
  acts_as_external_archive
  
  named_scope :existing , :conditions => ["godziny.destroyed = ?", false]
  named_scope :destroyed, :conditions => ["godziny.destroyed = ?", true]
end
