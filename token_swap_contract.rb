require_relative 'smart_contract_base'

class TokenSwapContract < SmartContractBase
  def initialize(owner, token_a, token_b, fee)
    super(owner)
    @state[:token_a] = token_a
    @state[:token_b] = token_b
    @state[:fee] = fee
    @state[:liquidity] = { token_a: 0, token_b: 0 }
  end

  def add_liquidity(params)
    amount_a = params[:amount_a]
    amount_b = params[:amount_b]
    from = params[:from]

    @state[:liquidity][:token_a] += amount_a
    @state[:liquidity][:token_b] += amount_b
    emit_event('LiquidityAdded', { from: from, a: amount_a, b: amount_b })
    true
  end

  def swap(params)
    from_token = params[:from_token]
    to_token = params[:to_token]
    amount = params[:amount]

    return false unless [@state[:token_a], @state[:token_b]].include?(from_token)
    return false unless [@state[:token_a], @state[:token_b]].include?(to_token)

    fee_amount = amount * @state[:fee]
    swap_amount = amount - fee_amount
    emit_event('Swap', { from: from_token, to: to_token, amount: swap_amount })
    true
  end
end
