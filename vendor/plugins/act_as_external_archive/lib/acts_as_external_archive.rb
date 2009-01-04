module MyMod
module Acts
   module Roled 
     # included is called from the ActiveRecord::Base
     # when you inject this module

     def self.included(base) 
      # Add acts_as_roled availability by extending the module
      # that owns the function.
       base.extend AddActsAsMethod
     end 

     # this module stores the main function and the two modules for
     # the instance and class functions
     module AddActsAsMethod
       def acts_as_external_archive(options = {})
        # Here you can put additional association for the
        # target class.
        # belongs_to :role
        # add class and istance methods

         class_eval <<-END
           include MyMod::Acts::Roled::InstanceMethods    
         END
       end
     end

     # Istance methods
     module InstanceMethods 
      # doing this our target class
      # acquire all the methods inside ClassMethods module
      # as class methods.

      @@separator = '|!|'
      @@zamiennik = "&#124;&#33;&#124;"
  
      ## umiejszcza objekt w archiwum przed jego zapisaniem 
      def save
        temp = eval(self.class.name.to_s + ".find(" + self.id.to_s + ")") unless self.new_record? ## moze to zmienic, zeby nie odwolywac sie dodatkowo do bazy ? ;)
        
        wrk1 = self.changed?
        wrk2 = !self.new_record?
        wrk3 = super

        archiving temp unless !(wrk1 & wrk2 & wrk3)
        create_blank self unless !((wrk1 | !wrk2) & wrk3)
        
        wrk3
      end
  
      
      def current_with_desc
        archive = Archive.find(:last, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s])
        { :class           => self,
          :edited_by       => archive.edited_by,
          #:editors_stamp   => archive.editors_stamp,
          :editors_ip      => archive.editors_stamp.to_s.split(@@separator)[1],
          :editors_browser => archive.editors_stamp.to_s.split(@@separator)[3]
        }
      end
  
  
      ## objekty nie sa uzuwane, pole destroyed jest ustawiane na true
      def destroy
        self.destroyed = true
        save
      end
  
  
      def set_editors_stamp stamp
        @editors_stamp = stamp
      end
      
      def set_current_user user
        @current_user = user
      end
  
  
      ## zwraca wszystkie 
      def archives
        @@desc = 0
        rebuild_from_archive Archive.find(:all, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s], :order => :id)
      end
   
      def archives_with_desc
        @@desc = 1
        rebuild_from_archive Archive.find(:all, :conditions => ["class_name = ? AND class_id = ?", self.class.name, self.id.to_s], :order => :id)
      end
      
      ## dodaje objekt do archiwum
      private
      def create_blank temp
        archive = Archive.new
        archive.class_name      = temp.class.name
        archive.class_id        = temp.id.to_s
        archive.edited_by       = (@current_user.nil?) ? nil : @current_user.id
        archive.editors_stamp   = @editors_stamp
        archive.class_destroyed = temp.destroyed
        archive.save
      end
      
      private
      def archiving temp
        archive = Archive.find(:last, :conditions => ["class_name = ? AND class_id = ?", temp.class.name, temp.id.to_s])
        #archive.class_name      = temp.class.name
        #archive.class_id        = temp.id.to_s
        archive.class_destroyed = temp.destroyed        
        #archive.edited_by       = temp.edited_by
        #archive.editors_stamp   = temp.editors_stamp
        archive.body            = ""
        #archive.body_updated_at = temp.updated_at
    
        keys = temp.class.columns.collect{|c| c.name}
        for key in ["id", "edited_by", "editors_stamp", "destroyed", "updated_at"]
          keys.delete key
        end

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
 
        #last_one = set[0] unless !(set.size < 2)
        #puts (set.size < 2)
        #set.delete_at 0   unless !(set.size < 2)
        ## dla kazdej elementu w zbiorze
        for anything in set
        puts anything.id
        puts set.size
      
      
        ## tworzymy nowy objekt i uzupełniamy, pola ktore sa wymagane w kazdym obiekcie
        temp               = eval(anything.class_name << ".new")
        temp.id            = anything.class_id
        temp.destroyed     = anything.class_destroyed
        #temp.edited_by     = anything.edited_by
        #temp.editors_stamp = anything.editors_stamp
        temp.updated_at    = anything.created_at
      
        #tworzymy liste wszystkich pol w klasie
        keys  = temp.class.columns.collect{|c| c.name}
        types = temp.class.columns.collect{|c| c.sql_type}
      
        ## i usuwany z tej listy pola juz uzupelnione
        for key in ["id", "edited_by", "editors_stamp", "destroyed", "updated_at"]
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
            if @@desc == 0
              empty_set.add [temp]
            else
              empty_set.add [{:class => temp,
                              :edited_by => anything.edited_by,
                              #:editors_stamp => anything.editors_stamp,
                              :editors_ip => anything.editors_stamp.to_s.split(@@separator)[1],
                              :editors_browser => anything.editors_stamp.to_s.split(@@separator)[3]
                             }].to_a
            end
          end
        end
        puts empty_set.size
        ## zwracamy gotowy zbior
        if @@desc == 0
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

      #def self.find *args
      #  exists = false
      #
      #  for anything in args
      #    if anything.class.to_s == "Hash" && !anything[:conditions].nil?
      #      exists = true
      #      anything[:conditions][0] << " AND destroyed = ?"
      #      anything[:conditions] += [false]
      #    end
      #  end
      #  
      #  args += [{:conditions => ["destroyed = ?", false]}] unless exists
      # 
      #  super *args
      #end