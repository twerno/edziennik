class CreatePlany < ActiveRecord::Migration
  def self.up
    create_table :plany do |t|
      t.string :nazwa
      t.integer :semestr_id
      t.boolean :active

      t.boolean  :destroyed, :default => false
      t.integer  :edited_by
      t.text     :editors_stamp
      
      t.timestamps
    end
  end

  def self.down
    drop_table :plany
  end
end
