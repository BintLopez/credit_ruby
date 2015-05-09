class Transaction
  
  attr_accessor :id, :timestamp, :amount, :type

  def initialize(id, type, amount)
    @id = id
    @timestamp = Time.new
    @amount = amount
    @type = type
  end

end