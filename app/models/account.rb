class Account < ActiveRecord::Base
  has_many :account_transactions
  belongs_to :user

  def total
    account_transactions.sum(:value) || 0
  end

  def check_total_value
    if total <= critical_value && send_notifications
      CriticalValueMailer.notification(self)
    end
  end
end