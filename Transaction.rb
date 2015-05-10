require "date"

class Transaction
  
  	attr_accessor :id, :timestamp, :amount, :type, :day_stamp

  	def initialize(id)
    	@id = id
    	@timestamp = Time.now
    	@day_stamp = Date.today
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
			valid = true
			@type = type
		end
	end

	def get_amount
		if withdrawal?
			verb = "withdraw"
		elsif payment?
			verb = "pay"
		end
		puts "Great, you're making a #{type}."
		puts "What amount would you like to #{verb}?"
		@amount = gets.chomp.to_f
	end

end