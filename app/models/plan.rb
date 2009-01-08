class Plan < ActiveRecord::Base
  belongs_to :semestr
  has_many   :lekcje
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["plany.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["plany.destroyed = ?", true]
  
  named_scope :active,   :conditions => ["plany.active = ?", true]
  
  
  def self.aktualny date
    begin
      semestr = Semestr.existing.active.find(:first, :conditions => ["semestry.begin <= ? AND semestry.end >= ?", date, date])
      return Plan.existing.active.find_by_semestr_id semestr.id
    rescue
      return nil
    end  
  end
  

end
