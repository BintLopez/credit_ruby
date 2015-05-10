require "date"
require_relative "Transaction"
require_relative "Billing"

class CreditAccount

	attr_accessor :limit, :apr, :principal, :remaining_credit, :transactions, :start_date, :principals, :timestamps, :duration

	def initialize
		@transactions = Array.new
		@apr = 0.35
		@principal = 0
		puts "What's the limit on the account?"
		@limit = gets.chomp.to_f
		@remaining_credit = @limit
		billing_cycle
		@start_date = DateTime.now
	end

	def account_check
		return @principal, @remaining_credit
	end

	def balance_check
		puts "Your principal is now $#{principal}. \nYou have $#{remaining_credit} of available credit." 
	end

	#MAKE A FUNCTION THAT WHEN IT REACHES END_BILLING RESETS THE BILLING CYCLE

	def do_transaction
    	transaction = Transaction.new(@transactions.length, account_check)
    	transaction.complete_transaction
    	#amt_check(transaction)
    	@transactions << transaction
    	if (transaction.type == "withdrawal")
      		@principal += transaction.amount
	    elsif (transaction.type == "payment")
	      	@principal -= transaction.amount
    	end
    	@remaining_credit = @limit - @principal
    	puts "Thanks for making your transaction."
    	balance_check
  	end

  	def billing_cycle
		@start_billing = Date.today
		@end_billing = @start_billing + 30
	end

	def get_transactions
		@principals = []
		@timestamps = []
		@duration = []
		transactions.each do |t|
			@principals << t.acct_principal
			@timestamps << t.timestamp
		end
		@principals << @principal
		@timestamps << Time.now
		num_times = @timestamps.length - 1
		num_times.downto(0) do |i|
			@duration << @timestamps[i] - @timestamps[i-1]
		end
		#puts @duration
		num_times.downto(1) do |c|
			calc_interest(@principals[c], @duration[c])
		end
	end

  	def calc_interest(principal, duration)
  		interest = principal * @apr / 365 * duration
  		puts interest
  	end

end

#capitalized so could access in irb -- made it immutable?
Acct = CreditAccount.new
Acct.do_transaction
Acct.do_transaction
Acct.do_transaction
Acct.do_transaction
Acct.get_transactions
# puts "Start date is " + acct.start_date.to_s
# Learned:  can't use strftime with DateTime obj... only on Time
# puts acct.start_date.strftime("%Y-%m-%d %H:%M:%S")