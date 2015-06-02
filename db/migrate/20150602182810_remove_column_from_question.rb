class RemoveColumnFromQuestion < ActiveRecord::Migration
  def change
  	remove_column :questions, :parent_question_id
  end
end
