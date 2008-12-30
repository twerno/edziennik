class Obecnosc < ActiveRecord::Base
  belongs_to :lista
  belongs_to :uczen
  belongs_to :lekcja
  #belongs_to :przedmiot, :through => :listy
  
  acts_as_external_archive
end
