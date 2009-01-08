class Lekcja < ActiveRecord::Base
  belongs_to :plan
  belongs_to :godzina
  belongs_to :lista
  
#  has_many :listy
  has_many :obecnosci
  has_many :oceny
  
  has_one :przedmiot, :through => :lista
  
  acts_as_external_archive
  
  named_scope :existing ,   :conditions => ["lekcje.destroyed = ?", false]
  named_scope :destroyed,   :conditions => ["lekcje.destroyed = ?", true] 
  #named_scope :cp, lambda {|*args| {:include => :lista, :conditions => [scope_or "listy.id", *args] }}
  named_scope :cp2, :include => :lista, :conditions => ["listy.grupa_id = ?", 1]
  
  
  def scope_or model, args
    s= "("
    args.each {|c|
      s << model << " = " << c.to_s << " OR " 
    }
    s = s[0..s.length-5]
    s << ")"
    # << scope_or("listy.id", @grupy.collect{|c| c.id})
  end
end
