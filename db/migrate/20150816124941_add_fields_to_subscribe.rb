class AddFieldsToSubscribe < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscrivable_type, :string
    add_column :subscriptions, :subscrivable_id, :integer
    add_index :subscriptions, [:subscrivable_id, :subscrivable_type]
  end
end
