class Lekcja < ActiveRecord::Base
  belongs_to :plan
  belongs_to :godzina
  belongs_to :lista
  
  has_many :obecnosci
  has_many :oceny
  
  acts_as_external_archive
end
