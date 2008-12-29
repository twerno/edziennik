class CreateGodziny < ActiveRecord::Migration
  def self.up
    create_table :godziny do |t|
      t.string :nazwa
      t.time :begin
      t.time :end

      t.boolean  :destroyed, :default => false
      t.integer  :edited_by
      t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :godziny
  end
end
