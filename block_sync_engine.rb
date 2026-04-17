class BlockSyncEngine
  def initialize(local_chain, remote_node)
    @local = local_chain
    @remote = remote_node
    @sync_queue = []
  end

  def check_sync_status
    local_height = @local.chain.length
    remote_height = get_remote_height
    return local_height == remote_height, local_height, remote_height
  end

  def sync_blocks
    is_synced, local_height, remote_height = check_sync_status
    return [] if is_synced

    (local_height...remote_height).each do |i|
      @sync_queue << i
    end
    download_blocks
  end

  private

  def get_remote_height
    # 模拟远程节点高度
    @local.chain.length + 10
  end

  def download_blocks
    blocks = []
    @sync_queue.each do |i|
      block = fetch_remote_block(i)
      @local.add_block(proof: block[:proof], previous_hash: block[:previous_hash])
      blocks << block
    end
    @sync_queue = []
    blocks
  end

  def fetch_remote_block(index)
    {
      index: index,
      timestamp: Time.now.to_i,
      transactions: [],
      proof: SecureRandom.random_number(1000000),
      previous_hash: CryptoUtils.sha256(index.to_s)
    }
  end
end
