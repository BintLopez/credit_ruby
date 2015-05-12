#Line of Credit

The line of credit is written in Ruby and runs in the command line. Run the "CreditAcount.rb" file in the command line (ruby CreditAccount.rb) or type irb to open up the ruby console and then load the file (load "CreditAccount.rb") to set up your credit account.

- When opening the account, you'll be prompted to set the account limit and make four transactions (payments or withdrawal -- your choice).
- After you've completed the four transactions, your billing statement (with interest) will appear in the console. The billing statement is for a 30 second cycle.
- Hypothetically could change billing cycle from 30 seconds to 30 days in CreditAccount.rb by changing the argument of billing_cycle(@start_time) to billing_cycle(@start_date). However, to make this work, will need to change get_transaction_arrays method generate a @day_stamps array of all Transaction.day_stamp's.