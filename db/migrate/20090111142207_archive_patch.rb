class ArchivePatch < ActiveRecord::Migration
  def self.up
    #remove_column :archives, :action
    #add_column :archives, :archive_action, :string
  end

  def self.down
  end
end
