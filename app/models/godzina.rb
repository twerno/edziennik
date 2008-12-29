class Godzina < ActiveRecord::Base
  has_many :lekcje
  
  acts_as_archive
end
