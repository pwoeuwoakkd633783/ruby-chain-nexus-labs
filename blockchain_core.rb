require 'digest/sha2'
require 'json'

class BlockchainCore
  attr_reader :chain, :pending_transactions

  def initialize
    @chain = []
    @pending_transactions = []
    create_genesis_block
  end

  def create_genesis_block
    add_block(previous_hash: '0', proof: 100)
  end

  def add_block(proof:, previous_hash: nil)
    block = {
      index: @chain.length + 1,
      timestamp: Time.now.to_i,
      transactions: @pending_transactions,
      proof: proof,
      previous_hash: previous_hash || hash(last_block)
    }
    @pending_transactions = []
    @chain << block
    block
  end

  def add_transaction(sender:, recipient:, amount:)
    @pending_transactions << {
      sender: sender,
      recipient: recipient,
      amount: amount
    }
    last_block[:index] + 1
  end

  def hash(block)
    Digest::SHA256.hexdigest(JSON.dump(block.sort.to_h))
  end

  def last_block
    @chain.last
  end
end
