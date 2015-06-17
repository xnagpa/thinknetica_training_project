class RemoveDefaultFromQuestion < ActiveRecord::Migration
  def change
  	change_column_default('answers', 'user_id', nil)
  	change_column_default('questions', 'user_id', nil)
  end
end
