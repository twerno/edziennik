class ObecnoscPatch < ActiveRecord::Migration
  def self.up
    add_column :obecnosci, :data, :string
  end

  def self.down
  end
end
