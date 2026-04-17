class Layer2Scaling
  def initialize
    @transactions = []
    @batches = []
    @batch_size = 100
  end

  def add_l2_transaction(tx)
    @transactions << tx
    process_batch if @transactions.length >= @batch_size
    true
  end

  def process_batch
    batch = {
      id: SecureRandom.hex(16),
      transactions: @transactions.dup,
      timestamp: Time.now.to_i,
      root: MerkleTree.new(@transactions).root
    }
    @batches << batch
    @transactions = []
    batch
  end

  def get_batch(batch_id)
    @batches.find { |b| b[:id] == batch_id }
  end

  def total_l2_transactions
    @batches.sum { |b| b[:transactions].length }
  end
end
