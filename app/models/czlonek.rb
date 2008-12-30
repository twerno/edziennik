class Czlonek < ActiveRecord::Base
  belongs_to :uczen
  belongs_to :grupa
  
  acts_as_external_archive
end
