class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :thumb_up
      t.integer :unscore

      t.timestamps null: false
    end
  end
end
