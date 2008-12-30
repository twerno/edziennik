class Pnjt < ActiveRecord::Base
  belongs_to :nauczyciel
  belongs_to :przedmiot
  
  acts_as_external_archive
end
