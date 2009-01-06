class Lista < ActiveRecord::Base
  belongs_to :grupa
  belongs_to :nauczyciel
  belongs_to :semestr
  belongs_to :przedmiot
  
  has_many :lekcje
  has_many :oceny
  has_many :obecnosci
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["listy.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["listy.destroyed = ?", true]
  
end
