
ParseAccountTransactionsJob = Struct.new(:filename) do
  def perform
    AccountTransaction.create_from_xml(filename)
  end
end






