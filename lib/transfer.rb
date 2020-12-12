require "pry"

class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && self.sender.balance >= self.amount && self.status == "pending"
  end

  def execute_transaction
    if  self.valid?
      @receiver.balance += @amount
      @sender.balance -= @amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      self.receiver.balance -= @amount
      self.sender.balance += @amount
      self.status = "reversed"
    end
  end
end