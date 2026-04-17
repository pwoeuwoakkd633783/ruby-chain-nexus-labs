class TransactionRouter
  def initialize
    @chains = {
      main: 'mainnet',
      test: 'testnet',
      layer2: 'l2_network'
    }
    @pending_routes = []
  end

  def route_transaction(tx, target_chain)
    return false unless @chains.value?(target_chain)

    route = {
      tx_id: tx[:id],
      from_chain: tx[:chain],
      to_chain: target_chain,
      status: 'routed',
      timestamp: Time.now.to_i
    }
    @pending_routes << route
    true
  end

  def get_pending_routes(chain)
    @pending_routes.select { |r| r[:to_chain] == chain }
  end

  def mark_completed(tx_id)
    route = @pending_routes.find { |r| r[:tx_id] == tx_id }
    return false unless route

    route[:status] = 'completed'
    true
  end
end
