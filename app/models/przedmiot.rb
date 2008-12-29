class Przedmiot < ActiveRecord::Base
  has_many :pnjts
  has_many :nauczyciele, :through => :pnjts
  has_many :oceny,       :through => :listy
  has_many :obecnosci,   :through => :listy
  has_many :listy
  
  acts_as_archive
end
