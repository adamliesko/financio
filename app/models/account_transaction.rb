class AccountTransaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  after_create :check_account_total

  def category_name
    category.name
  end

  def check_account_total
    account.check_total_value
  end

end