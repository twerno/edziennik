class Uczen < ActiveRecord::Base
  #belongs_to :user
  has_one   :user
  belongs_to :rodzic
  has_many   :czlonkowie
  has_many   :oceny
  has_many   :obecnosci
  has_many   :grupy, :through => :czlonkowie
  
  acts_as_external_archive
  
  named_scope :existing , :conditions => ["uczniowie.destroyed = ?", false]
  named_scope :destroyed, :conditions => ["uczniowie.destroyed = ?", true]
  
  #named_scope :nalezy_do, :include => :czlonkowie, :conditions => ["czlonkowie.uczen_id = ?", self.id]
  
  
  def klasa
    c = Czlonek.existing.u(self.id).collect{|ccc| ccc.grupa.id}
    k = []
    c.each do |key|
      k += Grupa.existing.klasa.find(:all, :conditions => ["id = ?", key])
    end  
    (k.nil? || k.empty?) ? [] : k[0]
  end
  
  
  def grupy
    c = Czlonek.existing.u(self.id).collect{|ccc| ccc.grupa.id}
    g = []
    c.each do |key|
      g += Grupa.existing.grupy.find(:all, :conditions => ["id = ?", key])
    end
    (g.nil? || g.empty?) ? [] : g
  end

  
  def new_key
    Base64.encode64(Digest::SHA1.digest("#{rand(1<<64)}/#{Time.now.to_f}/#{Process.pid}/#{eval("self."+self.class.column_names[0])}/#{eval("self."+self.class.column_names[1])}/#{eval("self."+self.class.column_names[2])}"))[0..5]
  end 
  
  
end
