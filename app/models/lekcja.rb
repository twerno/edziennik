class Lekcja < ActiveRecord::Base
  belongs_to :plan
  belongs_to :godzina
  belongs_to :lista
  
  has_many :listy
  has_many :obecnosci
  has_many :oceny
  
  has_one :przedmiot, :through => :lista
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["lekcje.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["lekcje.destroyed = ?", true] 
  named_scope :cp, lambda {|*args| {:include => :lista, :conditions => ["listy.grupa_id = ?", args[0]] }}
  named_scope :cp2, :include => :lista, :conditions => ["listy.grupa_id = ?", 1]
end
