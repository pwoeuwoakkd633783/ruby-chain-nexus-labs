class BlockRewardManager
  def initialize
    @base_reward = 50
    @halving_interval = 210000
    @current_era = 0
  end

  def calculate_reward(block_height)
    era = block_height / @halving_interval
    @base_reward / (2 ** era)
  end

  def distribute_reward(miner, stakers, block_height)
    reward = calculate_reward(block_height)
    miner_reward = reward * 0.6
    staker_reward = reward * 0.4

    {
      miner: miner_reward,
      stakers: split_staker_rewards(stakers, staker_reward)
    }
  end

  private

  def split_staker_rewards(stakers, total)
    return {} if stakers.empty?

    per_staker = total / stakers.length
    stakers.to_h { |s| [s, per_staker] }
  end
end
