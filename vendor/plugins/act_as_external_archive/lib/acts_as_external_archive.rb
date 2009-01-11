module Twerno
module Acts
   module External_Archive

     def self.included(base) 
       base.extend AddActsAsMethod
     end 

     module AddActsAsMethod
       def acts_as_external_archive(options = {})

         class_eval <<-END
           include Twerno::Acts::External_Archive::InstanceMethods    
         END
       end
     end

## metody:
## 1 : create
## 2 : edit
## 3 : delete
## 4 : restore



     module InstanceMethods 

      @@separator = '|!|'
      @@zamiennik = "&#124;&#33;&#124;"
      #@@method    = 0
  
  
      def init
        super
        #@method = ""
      end
      ## umiejszcza objekt w archiwum przed jego zapisaniem 
      def save
        temp = eval(self.class.name.to_s + ".find(" + self.id.to_s + ")") unless self.new_record? ## moze to zmienic, zeby nie odwolywac sie dodatkowo do bazy ? ;)

        @method = "Create" unless !self.new_record?  ## ustawienie akcji na create, jesli nowy rekord

        changes = self.changes
        changes.delete "updated_at"

        wrk1 = self.changed?
        wrk2 = !self.new_record?
        wrk3 = super

        (
          archiving temp unless !(wrk1 & wrk2 & wrk3)
          create_blank self, changes unless !((wrk1 | !wrk2) & wrk3)
        ) unless !(changes.size > 0)

        wrk3
      end


#      def continue_with_new_id
#        #puts self.destroyed
#        self.contiuned = true
#        self.destroy
#        puts "AAAAAAAAA"
#        attributes = self.attributes
#        attributes.delete "continued"
#        attributes.delete "destroyed"
#                puts "bbbbbbbb"
#        attributes[:indexes] = (attributes[:indexes].to_s.empty?) ? ',' << self.id << ',' : attributes[:indexes] << self.id << ','
#         
#        new = eval(self.class_name << ".new")
#        new.attributes = attributes
#        new.save
#        
#        new
#        #puts self.destroyed
#        #new = Archive.new (Archive.find(:last, :conditions["class_name = ? AND class_id = ?", self.class_name , self.class_id ]).attributes.delete( "updated_at")).attributes.delete( "created_at")
#        
#        #puts new
#        
#      end
      
      
      def current_with_desc
        archive = Archive.find(:last, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s])
 
        { :id              => archive.id,
          :class           => self,
          :edited_by       => archive.edited_by,
          #:editors_stamp   => archive.editors_stamp,
          :editors_ip      => archive.editors_ip,#.to_s.split(@@separator)[1],
          :editors_browser => archive.editors_browser,#.to_s.split(@@separator)[3],
          :changes         => anything.changes.to_s.split( ','),
          :method          => anything.method
        }
      end
  
  
      ## objekty nie sa uzuwane, pole destroyed jest ustawiane na true
      def destroy
        self.destroyed = true
        @method = "Delete"       ## ustawienie akcji na delete
        save
      end
  
      def restore id, editors_stamp
		set_editors_stamp editors_stamp
        archive = Archive.find_by_id id
        @desc = 0
        old     = rebuild_from_archive( archive)[0]
        self.attributes = old.attributes
        @method = "Restore"
        self.save
      end

      def set_editors_stamp editors_stamp
        @editors_ip      = editors_stamp[:editors_ip]
        @editors_browser = editors_stamp[:editors_browser]
        @current_user    = editors_stamp[:current_user]
      end
      
      def set_current_user user
        
      end
  
  
      ## zwraca wszystkie 
      def archives
        @desc = 0
        rebuild_from_archive Archive.find(:all, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s], :order => :id)
      end
   
      def archives_with_desc
        @desc = 1
        rebuild_from_archive Archive.find(:all, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s], :order => :id)
      end
      
      ## dodaje objekt do archiwum
      private
      def create_blank temp, changes
        archive = Archive.new
        archive.class_name      = temp.class.name
        archive.class_id        = temp.id.to_s
        #archive.version        = (temp.version.nil?) ? 0 : temp.version+1
        archive.edited_by       = (@current_user.nil?) ? nil : @current_user
        archive.editors_ip      = @editors_ip
        archive.editors_browser = @editors_browser
        archive.class_destroyed = temp.destroyed
        archive.method          = (@method.to_s.empty?) ? "Edit" : @method

        keys = changes.keys
        keys.delete "updated_at"
        archive.changes = "" unless !(keys.size != 0)

        for key in keys
          archive.changes << key << ","
        end 
        archive.save
      end
      
      private
      def archiving temp
        archive = Archive.find(:last, :conditions => ["class_name = ? AND class_id = ?", temp.class.name, temp.id.to_s])
        archive.class_destroyed = temp.destroyed        
        #archive.body            = ""
        #archive.changes         = ""

        keys = temp.class.columns.collect{|c| c.name}
        for key in ["id", "edited_by", "editors_ip", "editors_browser", "destroyed", "updated_at"]
          keys.delete key
        end

        archive.body = "" unless !(keys.size != 0)

        for key in keys
          archive.body << key << @@separator
          archive.body << eval("temp." << key).to_s.gsub(@@separator, @@zamiennik)
          archive.body << @@separator
        end       

        archive.save
      end

    private
      def rebuild_from_archive set
    
        ## tworzymy pusty zbior
        empty_set = "".to_set
 
        set = set.to_a
        ## dla kazdej elementu w zbiorze
        for anything in set
        #puts anything.id
        #puts set.size
      
      
        ## tworzymy nowy objekt i uzupełniamy, pola ktore sa wymagane w kazdym obiekcie
        temp               = eval(anything.class_name << ".new")
        temp.id            = anything.class_id
        temp.destroyed     = anything.class_destroyed
        temp.updated_at    = anything.created_at
      
        #tworzymy liste wszystkich pol w klasie
        keys  = temp.class.columns.collect{|c| c.name}
        types = temp.class.columns.collect{|c| c.sql_type}
      
        ## i usuwany z tej listy pola juz uzupelnione
        for key in ["id", "edited_by", "editors_ip", "editors_browser", "destroyed", "updated_at"]
          index = keys.index key
          types.delete_at index unless index.nil?
          keys.delete_at  index unless index.nil?
        end
      
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
            if @desc == 0
              empty_set.add [temp]
            else
              empty_set.add [{:id    => anything.id,
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
        end
        puts empty_set.size
        ## zwracamy gotowy zbior
        if @desc == 0
          empty_set.add [self]             ## jesli rekord nie zostal zapisany, to nie wyswietla listy, a jedynie ten jeden rekord
          empty_set.to_a.flatten.reverse
        else
          empty_set.add [current_with_desc]
          empty_set.to_a.flatten
        end  
      end


      def self.included(aClass)
        aClass.extend ClassMethods
      end 

       module ClassMethods
               


       end 

     end 
   end
end
end