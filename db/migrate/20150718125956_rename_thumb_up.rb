class RenameThumbUp < ActiveRecord::Migration
  def change
    rename_column :votes, :thumb_up, :score
  end
end
