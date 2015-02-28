class AccountTransaction < ActiveRecord::Base
  has_one :category
end