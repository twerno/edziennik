class CreateNauczyciele < ActiveRecord::Migration
  def self.up
    create_table :nauczyciele do |t|
      t.string :imie
      t.string :nazwisko
      t.string :pesel
      
      #t.string   :key      
      t.integer :user_id
      #t.integer :pnjt

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :nauczyciele
  end
end
