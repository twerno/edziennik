class Czlonek < ActiveRecord::Base
  belongs_to :uczen
  belongs_to :grupa
  
  acts_as_external_archive
  
  named_scope :existing , :conditions => ["destroyed = ?", false]
  named_scope :destroyed, :conditions => ["destroyed = ?", true]
end
