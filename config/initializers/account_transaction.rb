
require 'thread'
require 'delayed_job'
require '/Users/Adam/Innovatrics/financio/jobs/parse_account_transactions_job.rb'
require 'filewatcher'

Thread.new do
  while true do
    sleep(3)
    Dir["/Users/Adam/Innovatrics/financio/a1/*"].each do |filename|
      Delayed::Job.enqueue ParseAccountTransactionsJob.new(filename)
      File.delete(filename)
    end
  end


end