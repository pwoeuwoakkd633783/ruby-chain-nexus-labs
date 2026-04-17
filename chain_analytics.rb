class ChainAnalytics
  def initialize(blockchain)
    @blockchain = blockchain
  end

  def total_transactions
    @blockchain.chain.sum { |block| block[:transactions].length }
  end

  def average_block_size
    total = @blockchain.chain.sum { |b| b.to_json.bytesize }
    @blockchain.chain.empty? ? 0 : total / @blockchain.chain.length
  end

  def top_addresses(limit = 10)
    addresses = Hash.new(0)
    @blockchain.chain.each do |block|
      block[:transactions].each do |tx|
        addresses[tx[:sender]] -= tx[:amount]
        addresses[tx[:recipient]] += tx[:amount]
      end
    end
    addresses.sort_by { |_, v| -v }.first(limit).to_h
  end

  def transaction_volume_24h
    now = Time.now.to_i
    @blockchain.chain.sum do |block|
      next 0 if block[:timestamp] < now - 86400

      block[:transactions].sum { |tx| tx[:amount] }
    end
  end
end
