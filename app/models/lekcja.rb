class Lekcja < ActiveRecord::Base
  belongs_to :plan
  belongs_to :godzina
  
  has_many :listy
  has_many :obecnosci
  has_many :oceny
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["destroyed = ?", true]  
end
