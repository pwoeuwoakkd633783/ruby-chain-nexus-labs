require_relative 'blockchain_core'
require_relative 'consensus_protocol'
require_relative 'p2p_network'
require_relative 'wallet_manager'
require_relative 'api_gateway'

# 区块链主程序入口
def main
  # 初始化核心组件
  blockchain = BlockchainCore.new
  consensus = ConsensusProtocol.new(blockchain)
  network = P2PNetwork.new
  wallet = WalletManager.new

  puts "=== 区块链节点启动 ==="
  puts "钱包地址: #{wallet.address}"
  puts "创世区块已创建: #{blockchain.chain[0][:index]}"

  # 启动API服务
  api = APIGateway.new(blockchain)
  Thread.new { api.run! }

  # 启动P2P网络
  Thread.new { network.start_server }

  # 主循环
  loop do
    sleep 30
    puts "当前区块高度: #{blockchain.chain.length}"
    puts "待处理交易: #{blockchain.pending_transactions.length}"
  end
end

# 启动程序
main if __FILE__ == $PROGRAM_NAME
