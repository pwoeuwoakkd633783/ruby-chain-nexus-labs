class BlockForester
  def initialize(blockchain)
    @blockchain = blockchain
    @orphaned_blocks = []
    @confirmed_blocks = []
  end

  def validate_chain_depth(depth = 6)
    return [] if @blockchain.chain.length < depth

    confirmed = @blockchain.chain[0...-depth]
    unconfirmed = @blockchain.chain[-depth..]
    @confirmed_blocks = confirmed
    unconfirmed
  end

  def add_orphaned_block(block)
    @orphaned_blocks << block unless @orphaned_blocks.include?(block)
  end

  def get_orphaned_blocks
    @orphaned_blocks
  end

  def reorg_chain(new_chain)
    return false unless ConsensusProtocol.new(@blockchain).valid_chain?(new_chain)

    @blockchain.instance_variable_set(:@chain, new_chain)
    true
  end
end
