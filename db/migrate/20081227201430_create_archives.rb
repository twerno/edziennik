class CreateArchives < ActiveRecord::Migration
  def self.up
    create_table  :archives do |t|
      t.string    :class_name
      t.string    :class_id
      #t.boolean   :continued, :default => false
      #t.text      :indexes
      #t.integer   :version
      t.boolean   :class_destroyed
      t.integer   :edited_by
      t.text      :editors_stamp
      t.text      :changes
      t.text      :body
      t.integer   :action
      #t.datetime :body_updated_at
      #t.datetime :created_at
      
      t.timestamps
      
    end
    
    add_index :archives, :class_name
    add_index :archives, :class_id
    add_index :archives, :editors_stamp
  end



  def self.down
    drop_table :archives
  end
end
