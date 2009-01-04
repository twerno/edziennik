class CreateUczniowie < ActiveRecord::Migration
  def self.up
    create_table :uczniowie do |t|
      t.string   :imie
      t.string   :nazwisko
      t.string   :pesel
      t.string   :nr_legitymacji
      t.integer  :rodzic_id
      t.boolean  :chlopiec
      
      #t.string   :key
      #t.integer  :user_id
      
      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :uczniowie
  end
end
