class AccountTransaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  after_create :check_account_total

  delegate :name, to: :category, prefix: true

  def check_account_total
    account.check_total_value
  end
end
