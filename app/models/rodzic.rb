class Rodzic < ActiveRecord::Base
  has_many   :uczniowie
  #belongs_to :user
  has_one  :user, :as => :polymorph
  
  acts_as_external_archive
end
