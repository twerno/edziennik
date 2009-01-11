class Archive < ActiveRecord::Base
  @@separator = '|!|'
  @@zamiennik = "&#124;&#33;&#124;"
  @@desc = 1
  
  
  def self.search(search, page)
    
    conditions_string = ""
    (
      for key in search.keys
        (
        conditions_string << " AND " unless conditions_string.empty?
        conditions_string << key.to_s + " = '" + search[key].to_s + "'"
        ) unless search[key].nil?
      end
    ) unless search.nil?

    #puts self.class.name    ## WTF ?? czemy self.class zwraca 'Class' ?? 
  paginate :per_page => 30, :page => page,
           :conditions => conditions_string,
           :order => 'id'
  end
  
  
  def scope_and hash
    conditions_string = ""
    (
    for key in hash.keys
      conditions_string << " AND " unless conditions_string.empty?
      conditions_string << key.to_s + " = '" + hash[key].to_s + "'"
    end
    ) unless search.nil?
    conditions_string
  end
  
  
  def self.restore id, editors_stamp
    archive =  Archive.find_by_id id
    puts archive.id
    obj = eval(archive.class_name + ".find_by_id " + archive.class_id.to_s)
    #obj.set_editors_stamp editors_stamp
    obj.restore id
  end
  
  
  def self.rebuild_from_archive set
  
    ## tworzymy pusty zbior
    empty_set = "".to_set
   
    set = set.to_a
    ## dla kazdej elementu w zbiorze
    for anything in set
    #puts anything.id.to_s + " " + anything.class_name
    #puts set.size
  
  
    ## tworzymy nowy objekt i uzupełniamy, pola ktore sa wymagane w kazdym obiekcie
    temp               = eval(anything.class_name + ".new")
    temp.id            = anything.class_id
    temp.destroyed     = anything.class_destroyed
    temp.updated_at    = anything.created_at
  
    #puts temp.class.columns.collect{|c| c.name}
    #tworzymy liste wszystkich pol w klasie
    keys  = temp.class.columns.collect{|c| c.name}
    types = temp.class.columns.collect{|c| c.sql_type}
  
    #puts keys
  
    ## i usuwany z tej listy pola juz uzupelnione
    for key in ["id", "edited_by", "editors_stamp", "destroyed", "updated_at"]
      index = keys.index key
      types.delete_at index unless index.nil?
      keys.delete_at  index unless index.nil?
    end
  #puts keys
  
    ## tworzymy liste pol i wartosci z archiwum
    if !anything.body.nil? && !anything.body.empty?
      body_split = anything.body.split @@separator
      body_fields_names = []
      body_fields_values= []
      for i in 0..body_split.size/2-1
        body_fields_names  += body_split[2*i].to_a
        value = body_split[2*i+1]
        body_fields_values += (value.nil? || value.empty?) ? [nil] : value.to_a
      end
      
  
      ## wpisujemy wartosci z archiwum do odpowiednich pol, dbajac o zachowanie typu
      for key in keys
        if body_fields_names.include? key
          case types[keys.index( key)]
            when "character varying(255)" || "text"
                str = body_fields_values[body_fields_names.index( key)]
                str.gsub(@@zamiennik, @@separator) unless str.nil?
                eval("temp." << key << "= " << ((str.nil?) ? "nil" : "'" << str << "'.to_s"))
            when "integer"
                int = body_fields_values[body_fields_names.index( key)]
                #puts int.nil? || int.empty?
                int = (int.nil? || int.empty?) ? nil : int
                eval("temp." << key << "= '" << ((int.nil?) ? "'" : int <<"'.to_i"))
            when "boolean"
                bool = "nil"
                wnk = body_fields_values[body_fields_names.index( key)]       
                bool = (wnk == "true") ? "true" : "false" unless wnk.nil? || wnk.empty?
                eval("temp." << key << "=" << bool)
            when "timestamp without time zone"
                date = body_fields_values[body_fields_names.index( key)]
                eval("temp." << key << "= '" << ((date.nil? || date.empty?) ? "'" : date << "'.to_datetime"))
            when "date"
                date = body_fields_values[body_fields_names.index( key)]
                eval("temp." << key << "= '" << ((date.nil? || date.empty?) ? "'" : date << "'.to_date"))
            when "time without time zone"
                date = body_fields_values[body_fields_names.index( key)]
                eval("temp." << key << "= '" << ((date.nil? || date.empty?) ? "'" : date << "'.to_time"))
            end
          end
        end
    
        ## wrzucamy obiekt do zbioru (set)

      elsif anything.body.nil?
        puts anything.class_name + ".find_by_id " + anything.class_id.to_s
        temp = eval(anything.class_name + ".find_by_id " + anything.class_id.to_s)
    end
        if @@desc == 0
          empty_set.add [temp]
        else
          empty_set.add [{:id => anything.id,
                          :class => temp,
                          :edited_by => anything.edited_by,
                          #:editors_stamp => anything.editors_stamp,
                          :editors_ip => anything.editors_ip,#.to_s.split(@@separator)[1],
                          :editors_browser => anything.editors_browser,#.to_s.split(@@separator)[3],
                          :changes => anything.changes.to_s.split( ','),
                          :method => anything.method
                         }].to_a
        end
    
    end

    ## zwracamy gotowy zbior
    if @@desc == 0
      #empty_set.add [self]             ## jesli rekord nie zostal zapisany, to nie wyswietla listy, a jedynie ten jeden rekord
      empty_set.to_a.flatten.reverse
    else
      #empty_set.add [current_with_desc]
      empty_set.to_a.flatten
    end  
  end

    
   
  

end
