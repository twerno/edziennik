class Plan < ActiveRecord::Base
  belongs_to :semestr
  has_many   :lekcje
  
  acts_as_archive
end
