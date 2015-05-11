require "date"

class Transaction
  
  	attr_accessor :id, :timestamp, :amount, :type, :day_stamp, :acct_principal, :acct_remaining_credit

  	def initialize(id, acct_snapshot, type, amount)
    	@id = id
    	@timestamp = Time.now
    	@day_stamp = Date.today
    	@acct_principal = acct_snapshot[0]
    	@acct_remaining_credit = acct_snapshot[1]
    	@type = type
    	@amount = amount
  	end

  	def complete_transaction
  		@type = get_type
    	@amount = get_amount
    end

    def get_type
  		puts "Is this a payment or withdrawal?"
		@type = gets.chomp
		validate_type
	end

  	def withdrawal?
		if @type == "withdrawal"
			return true
		else
			false
		end
	end

	def payment?
		if @type == "payment"
			return true
		else
			false
		end
	end

	def validate_type
		if !withdrawal? && !payment?
			puts "Please type either 'payment' or 'withdrawal'."
			get_type
		else
			@type = @type
		end
	end

	def get_amount
		if withdrawal?
			verb = "withdraw"
		elsif payment?
			verb = "pay"
		end
		puts "What amount would you like to #{verb}?"
		@amount = gets.chomp.to_f
		validate_amt
	end

	def validate_amt
		if withdrawal? && @amount > @acct_remaining_credit
			puts "You can only take out up to the amount of your remaining credit: $#{acct_remaining_credit}."
			get_amount
		elsif payment? && @amount > @acct_principal	
			puts "You don't need to make a payment larger than #{acct_principal}."
			get_amount		
		else
			@amount = @amount
		end
	end

end