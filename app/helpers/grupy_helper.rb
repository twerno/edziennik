module GrupyHelper
  def fields_for_lista(lista, &block)
    prefix = lista.new_record? ? 'new' : 'existing'
    fields_for("grupa[#{prefix}_lista_attributes][]", lista, &block)
  end


  def add_lista_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :listy, :partial => 'lista', :object => Lista.new 
    end 
  end 
end
