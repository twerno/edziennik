module GrupyHelper
  
  def fields_for_czlonek(czlonek, &block)
    prefix = czlonek.new_record? ? 'new' : 'existing'
    fields_for("grupa[#{prefix}_czlonek_attributes][]", czlonek, &block)
  end
end
