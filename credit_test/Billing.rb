class Billing

	attr_accessor :total_due, :interest

	def calc_interest
		puts "This is the principal: $#{principal}."
		puts "This is the APR: $#{apr}"
	end

end

# NEED TO GATHER AN ARRAY OF ALL TRANSACTIONS BETWEEN BILLING CYCLE START AND END DATES
# THEN NEED TO CALCULATE THE AMT DAYS BETWEEN TRANSACTIONS SO THAT KNOW HOW LONG ANY GIVEN PRINCIPAL WAS OWED => NUM_DAYS @ AMT_OWED
# THEN DO THE CALCULATION FOR INTEREST... 
# @principal * @apr / 365 * num_days
