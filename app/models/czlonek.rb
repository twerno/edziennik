class Czlonek < ActiveRecord::Base
  belongs_to :uczen
  belongs_to :grupa
  
  acts_as_external_archive
  
  named_scope :existing , :conditions => ["czlonkowie.destroyed = ?", false]
  named_scope :destroyed, :conditions => ["czlonkowie.destroyed = ?", true]
  #named_scope :klasa, :include => :grupa, :conditions => ["grupa.klasa = ?", true]
  named_scope :u, lambda { |*args| {:conditions => ["uczen_id = ?", args[0]]} }
end
