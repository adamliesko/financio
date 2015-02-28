class AccountTransaction < ActiveRecord::Base
  belongs_to :category

  def category_name
    category.name
  end
end