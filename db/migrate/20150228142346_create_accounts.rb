class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :name
      t.boolean :send_notifications
      t.float :critical_value
    end
    add_index :accounts, :user_id
  end
end
