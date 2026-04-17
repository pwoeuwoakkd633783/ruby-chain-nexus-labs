require_relative 'smart_contract_base'

class TokenContract < SmartContractBase
  def initialize(owner, total_supply)
    super(owner)
    @state[:total_supply] = total_supply
    @state[:balances] = { owner => total_supply }
    @state[:allowances] = {}
  end

  def transfer(params)
    from = params[:from]
    to = params[:to]
    amount = params[:amount]

    return false unless @state[:balances][from].to_i >= amount

    @state[:balances][from] -= amount
    @state[:balances][to] ||= 0
    @state[:balances][to] += amount
    emit_event('Transfer', { from: from, to: to, amount: amount })
    true
  end

  def balance_of(params)
    @state[:balances][params[:address]] || 0
  end
end
