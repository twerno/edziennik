class CreateSemestry < ActiveRecord::Migration
  def self.up
    create_table :semestry do |t|
      t.string :nazwa
      t.date :begin
      t.date :end

      t.boolean  :destroyed, :default => false
      #t.integer  :edited_by
      #t.text     :editors_stamp

      t.timestamps
    end
  end

  def self.down
    drop_table :semestry
  end
end
