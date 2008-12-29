class CreateObecnosci < ActiveRecord::Migration
  def self.up
    create_table :obecnosci do |t|
      t.integer :wartosc
      t.integer :uczne_id
      t.integer :lista_id
      t.integer :lekcja_id

      t.boolean  :destroyed, :default => false
      t.integer  :edited_by
      t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :obecnosci
  end
end
