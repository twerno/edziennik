class Lista < ActiveRecord::Base
  belongs_to :grupa
  belongs_to :nauczyciel
  belongs_to :semestr
  belongs_to :przedmiot
  
  has_many :oceny
  has_many :obecnosci
  
  acts_as_external_archive
  
end
