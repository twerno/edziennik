class Rodzic < ActiveRecord::Base
  has_many   :uczniowie
  #belongs_to :user
  has_one  :user
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["rodzice.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["rodzice.destroyed = ?", true]
  
  
  validates_presence_of :imie_ojca
  validates_presence_of :imie_matki
  validates_presence_of :nazwisko
  validates_presence_of :nazwisko_panienskie
  validates_uniqueness_of :pesel, :case_sensitive => false
  
  def new_key
    Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}/#{eval("self."+self.class.column_names[0])}/#{eval("self."+self.class.column_names[1])}/#{eval("self."+self.class.column_names[2])}"))[0..5]
  end 
end
