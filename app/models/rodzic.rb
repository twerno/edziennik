class Rodzic < ActiveRecord::Base
  has_many   :uczniowie
  belongs_to :user
  
  acts_as_archive
end
