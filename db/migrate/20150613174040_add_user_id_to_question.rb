class AddUserIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :user_id, :integer, default: 1
  end
end
