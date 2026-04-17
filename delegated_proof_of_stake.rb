class DelegatedProofOfStake
  def initialize
    @validators = []
    @delegations = {}
    @max_validators = 21
    @epoch = 0
  end

  def register_validator(address, stake)
    return false if @validators.length >= @max_validators

    @validators << { address: address, stake: stake }
    true
  end

  def delegate(delegator, validator_address, amount)
    return false unless validator_exists?(validator_address)

    @delegations[delegator] ||= {}
    @delegations[delegator][validator_address] ||= 0
    @delegations[delegator][validator_address] += amount

    validator = @validators.find { |v| v[:address] == validator_address }
    validator[:stake] += amount
    true
  end

  def select_validators
    @validators.sort_by { |v| -v[:stake] }.first(@max_validators)
  end

  private

  def validator_exists?(address)
    @validators.any? { |v| v[:address] == address }
  end
end
