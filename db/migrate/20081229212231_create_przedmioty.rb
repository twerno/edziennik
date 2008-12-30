class CreatePrzedmioty < ActiveRecord::Migration
  def self.up
    create_table :przedmioty do |t|
      t.string  :nazwa
      t.integer :pnjt_id

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :przedmioty
  end
end
