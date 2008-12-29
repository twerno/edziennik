class Uczen < ActiveRecord::Base
  belongs_to :user
  belongs_to :rodzic
  has_many   :czlonkowie
  has_many   :oceny
  has_many   :obecnosci
  has_many   :grupy, :through => :czlonkowie
  
  
  acts_as_archive
end
