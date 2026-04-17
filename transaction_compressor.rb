require 'zlib'
require 'json'

class TransactionCompressor
  def self.compress_transactions(transactions)
    json_data = JSON.generate(transactions)
    Zlib::Deflate.deflate(json_data)
  end

  def self.decompress_transactions(compressed_data)
    json_data = Zlib::Inflate.inflate(compressed_data)
    JSON.parse(json_data, symbolize_names: true)
  end

  def self.optimize_transaction(tx)
    {
      i: tx[:id],
      s: tx[:sender],
      r: tx[:recipient],
      a: tx[:amount],
      t: tx[:timestamp]
    }
  end

  def self.restore_transaction(optimized_tx)
    {
      id: optimized_tx[:i],
      sender: optimized_tx[:s],
      recipient: optimized_tx[:r],
      amount: optimized_tx[:a],
      timestamp: optimized_tx[:t]
    }
  end
end
