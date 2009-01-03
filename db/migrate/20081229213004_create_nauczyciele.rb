class CreateNauczyciele < ActiveRecord::Migration
  def self.up
    create_table :nauczyciele do |t|
      t.string :imie
      t.string :nazwisko
      t.integer :user_id
      #t.integer :pnjt

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
    
    nauczyciel = Nauczyciel.new do |n|
      n.imie = 'admin'
      n.nazwisko = 'admin'
      n.user_id = 1
    end
    
    nauczyciel.save
  end

  def self.down
    drop_table :nauczyciele
  end
end
