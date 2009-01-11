class ArchivePatch2 < ActiveRecord::Migration
  def self.up
     #   remove_column :archives, :archive_action
    #add_column :archives, :method, :string
  end

  def self.down
  end
end
