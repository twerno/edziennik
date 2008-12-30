class CreatePnjts < ActiveRecord::Migration
  def self.up
    create_table :pnjts do |t|
      t.integer :nauczyciel_id
      t.integer :przedmiot_id

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :pnjts
  end
end
