require "date"

class Transaction
  
  attr_accessor :id, :timestamp, :amount, :type, :day_of_transaction

  def initialize(id, type, amount)
    @id = id
    @timestamp = Time.now
    @day_of_transaction = Date.today
    @amount = amount
    @type = type
  end

end