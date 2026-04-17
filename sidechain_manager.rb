class SidechainManager
  def initialize(main_chain)
    @main_chain = main_chain
    @sidechains = []
    @pegs = {}
  end

  def create_sidechain(name, consensus)
    sidechain = {
      id: SecureRandom.hex(8),
      name: name,
      consensus: consensus,
      status: 'active',
      created_at: Time.now.to_i
    }
    @sidechains << sidechain
    sidechain[:id]
  end

  def peg_asset(sidechain_id, asset, amount)
    return false unless sidechain_exists?(sidechain_id)

    @pegs[sidechain_id] ||= {}
    @pegs[sidechain_id][asset] ||= 0
    @pegs[sidechain_id][asset] += amount
    true
  end

  def transfer_to_sidechain(sidechain_id, address, amount)
    return false unless @pegs.dig(sidechain_id, 'token').to_i >= amount

    {
      tx_id: SecureRandom.hex(12),
      from: @main_chain,
      to: sidechain_id,
      address: address,
      amount: amount
    }
  end

  private

  def sidechain_exists?(id)
    @sidechains.any? { |s| s[:id] == id }
  end
end
