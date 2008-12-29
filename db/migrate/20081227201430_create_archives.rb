class CreateArchives < ActiveRecord::Migration
  def self.up
    create_table :archives do |t|
      t.string   :class_name
      t.string   :class_id
      t.boolean  :class_destroyed
      t.integer  :edited_by
      t.text     :editors_stamp
      t.text     :body
      t.datetime :body_updated_at
      t.datetime :created_at
      
    end
    
    add_index :archives, :class_id
  end



  def self.down
    drop_table :archives
  end
end
