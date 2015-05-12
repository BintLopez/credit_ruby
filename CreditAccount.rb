require "date"
require_relative "Transaction"

class CreditAccount

	attr_accessor :limit, :apr, :principal, :remaining_credit, :transactions, :start_time, :start_date, :principals, :timestamps, :duration, :amt_due

	def initialize
		@transactions = Array.new
		@apr = 0.35
		@principal = 0
		puts "What's the limit on the account?"
		@limit = gets.chomp.to_f
		@remaining_credit = @limit
		@start_time = Time.now
		@start_date = DateTime.now
		billing_cycle(@start_time)
		@principals = []
		@timestamps = [@start_time]
	end

	def account_check
		return @principal, @remaining_credit
	end

	def balance_check
		puts "Your principal is now $#{principal}. \nYou have $#{remaining_credit} of available credit." 
	end

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

  	def billing_cycle(day_or_time)
		@start_billing = day_or_time
		@end_billing = day_or_time + 30
		# @start_billing_test = @start_time
		# @end_billing_test = @start_time + 30
	end

	def get_duration
		@duration = []
		num_times = @timestamps.length - 1
		num_times.downto(1) do |i|
			diff = @timestamps[i] - @timestamps[i-1]
			@duration << diff
		end
		@duration = @duration.reverse
	end

	def get_transaction_arrays
		transactions.each do |t|
			if t.timestamp.between?(@start_billing, @end_billing)
				@principals << t.acct_principal
				@timestamps << t.timestamp
			end
		end
		@principals << @principal
		@timestamps << @end_billing
		get_duration
	end

	def calc_amt_due
		get_transaction_arrays
		interest = 0
		0.upto(@principals.length-1) do |i|
			interest += calc_interest(@principals[i], @duration[i])
		end
		amt_due = @principal + interest
		@amt_due = amt_due.round(2)
		puts "Your principal is #{principal}.\nTotal interest for this billing cycle is $#{interest}.\nThe total amount due is $#{amt_due}."
	end

  	def calc_interest(principal, duration)
  		interest = principal * @apr / 365 * duration
  		return interest.round(2)
  	end

end

Acct = CreditAccount.new
Acct.do_transaction
Acct.do_transaction
Acct.do_transaction
Acct.do_transaction
Acct.calc_amt_due