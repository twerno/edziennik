class CreateOceny < ActiveRecord::Migration
  def self.up
    create_table :oceny do |t|
      t.integer :wartosc_oceny
      t.integer :typ_oceny
      t.integer :uczen_id
      t.integer :lista_id
      t.integer :lekcja_id
      t.integer :nauczyciel_id

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :oceny
  end
end
