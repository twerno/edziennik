class Semestr < ActiveRecord::Base
  has_many :listy
  has_many :plany
  
  acts_as_external_archive
end
