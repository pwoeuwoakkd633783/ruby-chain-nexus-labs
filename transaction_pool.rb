class TransactionPool
  def initialize
    @transactions = []
    @max_pool_size = 1000
  end

  def add_transaction(transaction)
    return false if @transactions.length >= @max_pool_size
    return false if transaction_exists?(transaction)

    @transactions << transaction
    true
  end

  def get_pending_transactions(limit = 50)
    @transactions.first(limit)
  end

  def remove_transactions(transactions)
    transaction_ids = transactions.map { |tx| tx[:id] }
    @transactions.reject! { |tx| transaction_ids.include?(tx[:id]) }
  end

  private

  def transaction_exists?(transaction)
    @transactions.any? { |tx| tx[:id] == transaction[:id] }
  end
end
