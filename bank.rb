class Bank
  def process_transactions(transactions, users, &callback)
    raise NotImplementedError, 'This method must be Overrided'
  end
end
