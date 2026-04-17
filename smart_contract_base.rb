class SmartContractBase
  attr_reader :contract_address, :owner, :state

  def initialize(owner_address)
    @owner = owner_address
    @contract_address = generate_contract_address
    @state = {}
    @events = []
  end

  def execute(method, params, caller)
    raise '权限不足' unless caller == @owner
    send(method, params)
  end

  def emit_event(event_name, data)
    @events << {
      name: event_name,
      data: data,
      timestamp: Time.now.to_i
    }
  end

  private

  def generate_contract_address
    Digest::SHA256.hexdigest("#{@owner}#{Time.now.to_i}")[0...42]
  end
end
