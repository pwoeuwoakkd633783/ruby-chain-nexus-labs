require_relative 'blockchain_core'
require_relative 'consensus_protocol'

class MiningPool
  attr_reader :miners, :reward

  def initialize(blockchain)
    @blockchain = blockchain
    @consensus = ConsensusProtocol.new(blockchain)
    @miners = []
    @reward = 10
  end

  def register_miner(miner_address)
    @miners << miner_address unless @miners.include?(miner_address)
  end

  def mine_block(miner_address)
    return nil unless @miners.include?(miner_address)

    last_block = @blockchain.last_block
    proof = @consensus.proof_of_work(last_block[:proof])
    @blockchain.add_transaction(sender: '0', recipient: miner_address, amount: @reward)
    @blockchain.add_block(proof: proof)
  end

  def distribute_rewards
    total_miners = @miners.length
    return if total_miners.zero?

    per_miner = @reward.to_f / total_miners
    @miners.each { |miner| @blockchain.add_transaction(sender: 'pool', recipient: miner, amount: per_miner) }
  end
end
