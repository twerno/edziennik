class RodzicPatch < ActiveRecord::Migration
  def self.up
    #add_column :rodzice, :nazwisko, :string
    #remove_column :rodzice, :nazwistko
  end

  def self.down
  end
end
