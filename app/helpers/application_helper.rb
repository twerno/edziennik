module ApplicationHelper
  
  # Sets the page title and outputs title if container is passed in.
  # eg. <%= title('Hello World', :h2) %> will return the following:
  # <h2>Hello World</h2> as well as setting the page title.
  def title(str, container = nil)
    @page_title = str
    content_tag(container, str) if container
  end
  
  # Outputs the corresponding flash message if any are set
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << content_tag(:div, html_escape(flash[msg.to_sym]), :id => "flash-#{msg}") unless flash[msg.to_sym].blank?
    end
    messages
  end


  def płeć arg
    (arg) ? 'Chlopiec' : 'Dziewczynka'
  end


  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end


  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  
  def Uczniowie collection
    collection.uniq.sort_by{|s| s.nazwisko.to_s.upcase+" "+s.imie.to_s.upcase}
  end
  
  def imie arg
    begin
      imie = arg.imie.to_s
    rescue
      imie = ""
    end  
    
     begin
      nazwisko = arg.nazwisko.to_s
    rescue
      nazwisko = ""
    end  

    imie + " " + nazwisko
  end
  
end
