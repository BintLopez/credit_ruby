require_relative "Transaction"
require "date"
# require_relative "Billing"

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
	end

	def billing_cycle
		@start_billing = Date.today
		@end_billing = @start_billing + 30
	end

	#MAKE A FUNCTION THAT WHEN IT REACHES END_BILLING RESETS THE BILLING CYCLE

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
		puts "Great, you're making a #{type}."
		puts "What amount would you like to #{verb}?"
		amount = gets.chomp.to_f
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
    	puts "Thanks for making your transaction. \nYour principal is now $#{principal}. \nYour remaining credit is $#{remaining_credit}." 
  	end

  	# def calc_interest

  	# 	interest = @principal * @apr / 365 *
  	# end

end



# acct = CreditAccount.new
# acct.do_transaction