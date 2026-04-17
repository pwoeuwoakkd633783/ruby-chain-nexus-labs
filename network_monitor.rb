class NetworkMonitor
  def initialize(p2p_network)
    @network = p2p_network
    @metrics = { latency: {}, uptime: {}, bandwidth: {} }
    @start_time = Time.now.to_i
  end

  def measure_latency(node)
    start = Time.now.to_f
    @network.broadcast({ type: 'ping', timestamp: start })
    latency = ((Time.now.to_f - start) * 1000).round(2)
    @metrics[:latency][node] = latency
    latency
  end

  def get_uptime
    Time.now.to_i - @start_time
  end

  def record_bandwidth(node, bytes)
    @metrics[:bandwidth][node] ||= 0
    @metrics[:bandwidth][node] += bytes
  end

  def get_network_status
    {
      nodes: @network.nodes.length,
      uptime: get_uptime,
      avg_latency: @metrics[:latency].values.sum / @metrics[:latency].length.to_f
    }
  end
end
