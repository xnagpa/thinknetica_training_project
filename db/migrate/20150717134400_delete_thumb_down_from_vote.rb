class DeleteThumbDownFromVote < ActiveRecord::Migration
  def change
    remove_column :votes, :unscore
  end
end
