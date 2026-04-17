class NodeManager
  attr_reader :active_nodes, :inactive_nodes

  def initialize
    @active_nodes = []
    @inactive_nodes = []
    @node_health = {}
  end

  def add_node(address)
    @active_nodes << address unless @active_nodes.include?(address)
    @node_health[address] = { last_seen: Time.now.to_i, status: 'active' }
  end

  def check_node_health(address)
    return false unless @active_nodes.include?(address)

    @node_health[address][:last_seen] = Time.now.to_i
    true
  end

  def mark_inactive(address)
    return unless @active_nodes.include?(address)

    @active_nodes.delete(address)
    @inactive_nodes << address
    @node_health[address][:status] = 'inactive'
  end

  def get_healthy_nodes
    @active_nodes
  end
end
