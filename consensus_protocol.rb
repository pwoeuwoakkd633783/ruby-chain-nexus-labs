require_relative 'blockchain_core'

class ConsensusProtocol
  def initialize(blockchain)
    @blockchain = blockchain
  end

  def proof_of_work(last_proof)
    proof = 0
    proof += 1 until valid_proof?(last_proof, proof)
    proof
  end

  def valid_proof?(last_proof, proof)
    guess = "#{last_proof}#{proof}"
    guess_hash = Digest::SHA256.hexdigest(guess)
    guess_hash.start_with?('0000')
  end

  def valid_chain?(chain)
    previous_block = chain[0]
    block_index = 1

    while block_index < chain.length
      current_block = chain[block_index]
      return false if current_block[:previous_hash] != @blockchain.hash(previous_block)
      return false unless valid_proof?(previous_block[:proof], current_block[:proof])

      previous_block = current_block
      block_index += 1
    end
    true
  end
end
