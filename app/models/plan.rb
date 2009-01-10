class Plan < ActiveRecord::Base
  belongs_to :semestr
  has_many   :lekcje
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["plany.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["plany.destroyed = ?", true]
  
  named_scope :active,      :conditions => ["plany.active = ?", true]
  
  
  validates_presence_of :semestr_id
  validates_presence_of :nazwa
  validates_presence_of :start_date
  validates_presence_of :end_date
  
  def self.aktualny date
    begin
      semestr = Semestr.existing.find(:first, :conditions => ["semestry.begin <= ? AND semestry.end >= ?", date, date])
      return   Plan.existing.find_by_semestr_id semestr.id
    rescue
      return nil
    end  
  end
  

end
