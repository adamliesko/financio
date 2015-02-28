class Account < ActiveRecord::Base
  has_many :account_transactions

  def total
    account_transactions.sum(:value) || 0

  end
end