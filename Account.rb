require_relative "Transaction"

class CreditAccount

	attr_accessor :limit, :apr, :principal, :remaining_credit

	def get_principal
		puts "This is the principal: $#{principal}"
	end

	def do_transaction(type, amount)
    	transaction = Transaction.new(@transactions.length, type, amount)
    	@transactions << transaction
    	if (type == "withdrawal")
      		@principal += amount
	    elsif (type == "payment")
	      	@principal -= amount
    	end
  	end

end