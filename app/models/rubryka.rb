class Rubryka < ActiveRecord::Base
  belongs_to :lista
  has_many   :oceny
  
  acts_as_external_archive
end
