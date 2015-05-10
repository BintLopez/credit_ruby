require_relative "Transaction"
require "date"
require_relative "Billing"

class CreditAccount

	attr_accessor :limit, :apr, :principal, :remaining_credit, :transactions, :start_date

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

	def billing_cycle
		@start_billing = Date.today
		@end_billing = @start_billing + 30
	end

	def account_check
		puts "Your principal is now $#{principal}. \nYour remaining credit is $#{remaining_credit}." 
	end

	#MAKE A FUNCTION THAT WHEN IT REACHES END_BILLING RESETS THE BILLING CYCLE

	def amt_check(amount)
		if @remaining_credit + amount <= @limit	
			amount = amount	
		else
			puts "You don't need to make a payment."
			amount = 0
		end
		return amount
	end


	def init_transaction
		puts "Is this a payment or withdrawal?"
		type = gets.chomp
		if type == "withdrawal"
			verb = "withdraw"
		elsif type == "payment"
			verb = "pay"
		else
			puts "Please type either 'payment' or 'withdrawal'."
			type = gets.chomp
			if type == "withdrawal"
				verb = "withdraw"
			elsif type == "payment"
				verb = "pay"
			end
		end
		#puts "Great, you're making a #{type}."
		puts "What amount would you like to #{verb}?"
		amount = gets.chomp.to_f
		#amt_check(amount) -- (not currently working)
		return type, amount
	end

	def do_transaction
		user_input = init_transaction
		type = user_input[0]
		amount = user_input[1]
    	transaction = Transaction.new(@transactions.length, type, amount)
    	@transactions << transaction
    	if (type == "withdrawal")
      		@principal += amount
	    elsif (type == "payment")
	      	@principal -= amount
    	end
    	@remaining_credit = @limit - @principal
    	puts "Thanks for making your transaction."
    	account_check
  	end

  	# def calc_interest

  	# 	interest = @principal * @apr / 365 *
  	# end

end

#capitalized so could access in irb -- made it immutable?
Acct = CreditAccount.new
Acct.do_transaction
# puts "Start date is " + acct.start_date.to_s
# Learned:  can't use strftime with DateTime obj... only on Time
# puts acct.start_date.strftime("%Y-%m-%d %H:%M:%S")