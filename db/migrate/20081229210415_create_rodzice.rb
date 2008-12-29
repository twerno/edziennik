class CreateRodzice < ActiveRecord::Migration
  def self.up
    create_table :rodzice do |t|
      t.string :imie_ojca
      t.string :imie_matki
      t.string :nazwistko
      t.string :nazwisko_panienskie
      t.integer :user_id

      t.boolean  :destroyed, :default => false
      t.integer  :edited_by
      t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :rodzice
  end
end
