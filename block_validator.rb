require_relative 'blockchain_core'
require_relative 'consensus_protocol'

class BlockValidator
  def initialize(blockchain)
    @blockchain = blockchain
    @consensus = ConsensusProtocol.new(blockchain)
  end

  def validate_full_block(block)
    return false unless valid_index?(block)
    return false unless valid_timestamp?(block)
    return false unless valid_transactions?(block)
    return false unless valid_proof?(block)
    return false unless valid_previous_hash?(block)

    true
  end

  private

  def valid_index?(block)
    block[:index] == @blockchain.last_block[:index] + 1
  end

  def valid_timestamp?(block)
    block[:timestamp].is_a?(Integer) && block[:timestamp] > 0
  end

  def valid_transactions?(block)
    block[:transactions].is_a?(Array)
  end

  def valid_proof?(block)
    @consensus.valid_proof?(@blockchain.last_block[:proof], block[:proof])
  end

  def valid_previous_hash?(block)
    block[:previous_hash] == @blockchain.hash(@blockchain.last_block)
  end
end
