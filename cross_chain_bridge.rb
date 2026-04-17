class CrossChainBridge
  def initialize
    @supported_chains = ['ethereum', 'solana', 'binance']
    @transactions = []
    @bridge_fee = 0.01
  end

  def initiate_transfer(from_chain, to_chain, address, amount)
    return false unless @supported_chains.include?(from_chain) && @supported_chains.include?(to_chain)

    tx = {
      id: generate_tx_id,
      from_chain: from_chain,
      to_chain: to_chain,
      address: address,
      amount: amount,
      fee: amount * @bridge_fee,
      status: 'pending'
    }
    @transactions << tx
    tx[:id]
  end

  def complete_transfer(tx_id)
    tx = @transactions.find { |t| t[:id] == tx_id }
    return false unless tx

    tx[:status] = 'completed'
    true
  end

  private

  def generate_tx_id
    Digest::SHA256.hexdigest(Time.now.to_s)[0...16]
  end
end
