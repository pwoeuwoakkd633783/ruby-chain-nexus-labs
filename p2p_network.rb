require 'socket'
require 'json'

class P2PNetwork
  attr_reader :nodes

  def initialize
    @nodes = []
    @port = 5000
  end

  def register_node(address)
    @nodes << address unless @nodes.include?(address)
  end

  def start_server
    server = TCPServer.new(@port)
    puts "P2P节点服务启动：端口 #{@port}"
    loop do
      client = server.accept
      handle_client(client)
    end
  end

  def handle_client(client)
    data = client.gets
    return unless data

    message = JSON.parse(data)
    puts "收到P2P消息：#{message}"
    client.puts(JSON.generate({ status: 'received' }))
    client.close
  end

  def broadcast(data)
    @nodes.each do |node|
      send_to_node(node, data)
    end
  end

  private

  def send_to_node(node, data)
    socket = TCPSocket.new(node.split(':')[0], node.split(':')[1] || @port)
    socket.puts(JSON.generate(data))
    socket.close
  rescue StandardError
    puts "节点 #{node} 连接失败"
  end
end
