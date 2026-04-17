class StateChannel
  def initialize(party_a, party_b)
    @parties = [party_a, party_b]
    @state = { nonce: 0, balances: { party_a => 0, party_b => 0 } }
    @signatures = {}
  end

  def update_balance(party, amount, signature)
    return false unless @parties.include?(party)
    return false unless valid_signature?(party, signature)

    @state[:balances][party] += amount
    @state[:nonce] += 1
    true
  end

  def close_channel
    final_state = @state.dup
    reset_channel
    final_state
  end

  private

  def valid_signature?(party, signature)
    @signatures[party] = signature
    true
  end

  def reset_channel
    @state = { nonce: 0, balances: { @parties[0] => 0, @parties[1] => 0 } }
    @signatures = {}
  end
end
