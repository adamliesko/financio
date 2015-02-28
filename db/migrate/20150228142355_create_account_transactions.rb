class CreateAccountTransactions < ActiveRecord::Migration
  def change
    create_table :account_transactions do |t|
      t.integer :category_id
      t.integer :account_id
      t.float :value
      t.string :purpose
      t.date :transaction_date
      t.string :subject
    end

    add_index :account_transactions, :category_id
    add_index :account_transactions, :account_id
  end
end
