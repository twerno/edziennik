class RubrykaPatch < ActiveRecord::Migration
  def self.up
    #add_column :rubryki, :destroyed, :boolean,  :default => false
    add_column :plany, :start_date, :date
    add_column :plany, :end_date, :date
  end

  def self.down
  end
end
