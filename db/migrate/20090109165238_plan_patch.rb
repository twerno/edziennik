class PlanPatch < ActiveRecord::Migration
  def self.up
     add_column :rubryki, :destroyed, :boolean,  :default => false
  end

  def self.down
  end
end
