require 'resolv'

class PeerDiscovery
  def initialize(bootstrap_nodes = [])
    @bootstrap_nodes = bootstrap_nodes
    @discovered_peers = []
  end

  def discover_from_dns(domain)
    addresses = Resolv.getaddresses(domain)
    addresses.each { |addr| @discovered_peers << addr unless @discovered_peers.include?(addr) }
    @discovered_peers
  end

  def discover_from_bootstrap
    @bootstrap_nodes.each do |node|
      @discovered_peers << node unless @discovered_peers.include?(node)
    end
    @discovered_peers
  end

  def get_all_peers
    @discovered_peers.uniq
  end

  def clear_peers
    @discovered_peers = []
  end
end
