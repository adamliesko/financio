class AccountTransaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :account
  after_create :check_account_total

  delegate :name, to: :category, prefix: true

  def check_account_total
    account.check_total_value
  end

  def self.create_from_xml(filename)
    file = File.open(filename, "rb")
    content = file.read
    ActiveRecord::Base.transaction do
      transaction = AccountTransaction.new
      transaction.from_xml(content) if content
      transaction.save
    end
  end

  private

  def build_response(result)
    result_msg = result ? 'OK' : 'FAIL'
    File.open("a2/message#{id}.txt", w) { |f| f.write("<response>\n <message>#{result_msg}</message></response>") }
  end
end
