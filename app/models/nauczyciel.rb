class Nauczyciel < ActiveRecord::Base
  belongs_to :user
  belongs_to :grupa  #wychowawca
  has_many   :pnjts
  has_many   :przedmioty, :through => :pnjts
  has_many   :oceny
  has_many   :listy

  
  acts_as_external_archive
end
