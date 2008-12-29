class CreateCzlonkowie < ActiveRecord::Migration
  def self.up
    create_table :czlonkowie do |t|
      t.integer :uczen_id
      t.integer :grupa_id

      t.boolean  :destroyed, :default => false
      t.integer  :edited_by
      t.text     :editors_stamp
      
      t.timestamps
    end
  end

  def self.down
    drop_table :czlonkowie
  end
end
