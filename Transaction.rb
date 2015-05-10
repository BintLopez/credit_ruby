require "date"

class Transaction
  
  attr_accessor :id, :timestamp, :amount, :type, :day_stamp

  def initialize(id, type, amount)
    @id = id
    @timestamp = Time.now
    @day_stamp = Date.today
    @amount = amount
    @type = type
  end

end