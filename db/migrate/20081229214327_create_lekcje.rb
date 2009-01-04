class CreateLekcje < ActiveRecord::Migration
  def self.up
    create_table :lekcje do |t|
      t.integer :godzina_id
      t.integer :lista_id
      t.integer :plan_id
      t.integer :dzien_tygodnia
      
      t.date :data

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp
      
      t.timestamps
    end
  end

  def self.down
    drop_table :lekcje
  end
end
