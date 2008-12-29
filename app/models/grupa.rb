class Grupa < ActiveRecord::Base
  has_many :czlonkowie
  has_many :listy
  has_many :uczniowie, :through => :czlonkowie  ##
  belongs_to :nauczyciel
  
  acts_as_archive
end
