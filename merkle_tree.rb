require_relative 'crypto_utils'

class MerkleTree
  attr_reader :root

  def initialize(transactions)
    @transactions = transactions
    @nodes = []
    build_tree
  end

  def build_tree
    return if @transactions.empty?

    hashes = @transactions.map { |tx| CryptoUtils.sha256(tx) }
    @nodes = hashes.dup

    while hashes.length > 1
      hashes = compute_level(hashes)
      @nodes += hashes
    end

    @root = hashes.first
  end

  private

  def compute_level(hashes)
    level = []
    i = 0

    while i < hashes.length
      left = hashes[i]
      right = i + 1 < hashes.length ? hashes[i + 1] : left
      level << CryptoUtils.sha256(left + right)
      i += 2
    end

    level
  end
end
