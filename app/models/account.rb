class Account < ActiveRecord::Base
  has_many :account_transactions
  belongs_to :user

  validates :name, uniqueness: {scope: :user}

  def total
    account_transactions.sum(:value) || 0
  end

  def check_total_value
    CriticalValueMailer.notification(self).deliver if total <= critical_value && send_notifications
  end
end
