require "date"
require_relative "Transaction"
require_relative "Billing"

class CreditAccount

	attr_accessor :limit, :apr, :principal, :remaining_credit, :transactions, :start_date, :start_time, :principals, :timestamps, :duration

	def initialize(limit)
		@transactions = Array.new
		@apr = 0.35
		@principal = 0
		@limit = limit
		@remaining_credit = @limit
		billing_cycle
		@start_date = DateTime.now
		@start_time = Time.now
		@principals = []
		@timestamps = [@start_time]
		puts "Credit account created with limit:  $#{limit}."
	end

	def account_check
		return @principal, @remaining_credit
	end

	def balance_check
		puts "Principal is $#{principal}. \nRemaining credit is $#{remaining_credit}." 
	end

	#MAKE A FUNCTION THAT WHEN IT REACHES END_BILLING RESETS THE BILLING CYCLE

	def do_transaction(type, amount)
    	transaction = Transaction.new(@transactions.length, account_check, type, amount)
    	#transaction.complete_transaction
    	@transactions << transaction
    	if (transaction.type == "withdrawal")
      		@principal += transaction.amount
	    elsif (transaction.type == "payment")
	      	@principal -= transaction.amount
    	end
    	@remaining_credit = @limit - @principal
    	puts "Transaction complete -- #{type} of #{amount}."
    	balance_check
  	end

  	def billing_cycle
		@start_billing = Date.today
		@end_billing = @start_billing + 30
	end

	def get_transactions
		transactions.each do |t|
			@principals << t.acct_principal
			@timestamps << t.timestamp
		end
		@principals << @principal
		@timestamps << @start_time + 30
		# #puts @duration
		# num_times.downto(1) do |c|
		# 	calc_interest(@principals[c], @duration[c])
		# end
	end

	def get_duration
		@duration = []
		num_times = @timestamps.length - 1
		num_times.downto(1) do |i|
			diff = @timestamps[i] - @timestamps[i-1]
			@duration << diff.round
		end
		@duration = @duration.reverse
		puts @duration
	end

  	def calc_interest(principal, duration)
  		interest = principal * @apr / 365 * duration
  		puts interest
  	end

end

=begin
	
Someone creates a line of credit for 1000$ and 35% APR.

He draws 500$ on day one so his remaining credit limit is 500$ and his balance is 500$.
He pays back 200$ on day 15 and then draws another 100$ on day 25.  His total owed interest on
day 30 should be 500 * 0.35 / 365 * 15 + 300 * 0.35 / 365 * 10 + 400 * 0.35 / 365 * 5  which is
11.99.  Total payment should be 411.99.
	
=end


Acct = CreditAccount.new(1000)
Acct.do_transaction("withdrawal", 500)
Acct.do_transaction("payment", 200)
Acct.do_transaction("payment", 100)
