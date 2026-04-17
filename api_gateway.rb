require 'sinatra'
require 'json'

class APIGateway < Sinatra::Base
  def initialize(blockchain)
    @blockchain = blockchain
    super()
  end

  set :port, 3000
  set :show_exceptions, false

  get '/chain' do
    content_type :json
    { chain: @blockchain.chain, length: @blockchain.chain.length }.to_json
  end

  post '/transactions/new' do
    data = JSON.parse(request.body.read)
    index = @blockchain.add_transaction(
      sender: data['sender'],
      recipient: data['recipient'],
      amount: data['amount']
    )
    { message: "交易将加入区块 #{index}" }.to_json
  end

  get '/mine' do
    content_type :json
    last_block = @blockchain.last_block
    proof = ConsensusProtocol.new(@blockchain).proof_of_work(last_block[:proof])
    @blockchain.add_transaction(sender: '0', recipient: 'node', amount: 10)
    block = @blockchain.add_block(proof: proof)
    block.to_json
  end
end
