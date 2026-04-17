require_relative 'smart_contract_base'

class NFTContract < SmartContractBase
  def initialize(owner, name, symbol)
    super(owner)
    @state[:name] = name
    @state[:symbol] = symbol
    @state[:tokens] = {}
    @state[:owners] = {}
    @token_id = 1
  end

  def mint(params)
    to = params[:to]
    metadata = params[:metadata]

    @state[:tokens][@token_id] = metadata
    @state[:owners][@token_id] = to
    emit_event('Mint', { token_id: @token_id, to: to, metadata: metadata })
    @token_id += 1
  end

  def transfer_nft(params)
    from = params[:from]
    to = params[:to]
    token_id = params[:token_id]

    return false unless @state[:owners][token_id] == from

    @state[:owners][token_id] = to
    emit_event('TransferNFT', { token_id: token_id, from: from, to: to })
    true
  end
end
