class AddUserIdToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :user_id, :integer, default: 1
  end
end
