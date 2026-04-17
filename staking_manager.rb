class StakingManager
  def initialize
    @stakes = {}
    @rewards = {}
    @min_stake = 100
  end

  def stake(address, amount)
    return false if amount < @min_stake

    @stakes[address] ||= 0
    @stakes[address] += amount
    true
  end

  def unstake(address, amount)
    return false unless @stakes[address] && @stakes[address] >= amount

    @stakes[address] -= amount
    @stakes.delete(address) if @stakes[address].zero?
    true
  end

  def calculate_rewards
    total_staked = @stakes.values.sum
    return if total_staked.zero?

    @stakes.each do |address, amount|
      reward = (amount.to_f / total_staked) * 50
      @rewards[address] ||= 0
      @rewards[address] += reward
    end
  end

  def get_stake(address)
    @stakes[address] || 0
  end
end
