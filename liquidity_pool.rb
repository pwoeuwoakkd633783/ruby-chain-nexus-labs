class LiquidityPool
  def initialize(token_x, token_y)
    @token_x = token_x
    @token_y = token_y
    @reserve_x = 0
    @reserve_y = 0
    @lp_tokens = {}
  end

  def add_liquidity(user, amount_x, amount_y)
    @reserve_x += amount_x
    @reserve_y += amount_y

    lp_amount = amount_x * amount_y
    @lp_tokens[user] ||= 0
    @lp_tokens[user] += lp_amount
    emit_event('LiquidityAdded', { user: user, x: amount_x, y: amount_y })
    lp_amount
  end

  def swap_x_to_y(amount_x)
    return 0 if @reserve_x.zero?

    new_x = @reserve_x + amount_x
    new_y = (@reserve_x * @reserve_y) / new_x
    amount_y = @reserve_y - new_y

    @reserve_x = new_x
    @reserve_y = new_y
    amount_y
  end

  private

  def emit_event(name, data)
    # 事件记录
  end
end
