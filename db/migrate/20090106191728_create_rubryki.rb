class CreateRubryki < ActiveRecord::Migration
  def self.up
    create_table :rubryki do |t|
      t.string :opis
      t.integer :lista_id

      t.timestamps
    end
    
    add_column :oceny, :rubryka_id, :integer   
  end

  def self.down
    drop_table :rubryki
  end
end
