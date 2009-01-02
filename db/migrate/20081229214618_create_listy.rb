class CreateListy < ActiveRecord::Migration
  def self.up
    create_table :listy do |t|
      t.integer :grupa_id
      t.integer :nauczyciel_id
      t.integer :semestr_id
      t.integer :przedmiot_id
      t.integer :lekcja_id

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :listy
  end
end
