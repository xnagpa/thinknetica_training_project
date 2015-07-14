class AddDefaultToVotes < ActiveRecord::Migration
  def change
  	change_column :votes, :thumb_up,  :integer, default: 0
  	change_column :votes, :thumb_down,  :integer, default: 0
  end
end
