class GasCalculator
  def initialize
    @base_fee = 10
    @priority_fee = 2
    @gas_limit = 21000
  end

  def calculate_gas_fee(transaction_type)
    multiplier = get_multiplier(transaction_type)
    (@base_fee + @priority_fee) * @gas_limit * multiplier
  end

  def estimate_total_cost(amount, transaction_type)
    gas_fee = calculate_gas_fee(transaction_type)
    amount + gas_fee
  end

  def update_fees(base_fee, priority_fee)
    @base_fee = base_fee
    @priority_fee = priority_fee
  end

  private

  def get_multiplier(type)
    case type
    when :transfer then 1.0
    when :contract then 2.5
    when :nft then 1.8
    else 1.0
    end
  end
end
