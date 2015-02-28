class Category < ActiveRecord::Base
  has_many :account_transactions
end