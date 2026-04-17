require_relative 'smart_contract_base'
require_relative 'token_contract'
require_relative 'nft_contract'

class ContractDeployer
  def initialize(blockchain)
    @blockchain = blockchain
    @deployed_contracts = {}
  end

  def deploy_token_contract(owner, total_supply)
    contract = TokenContract.new(owner, total_supply)
    @deployed_contracts[contract.contract_address] = contract
    contract
  end

  def deploy_nft_contract(owner, name, symbol)
    contract = NFTContract.new(owner, name, symbol)
    @deployed_contracts[contract.contract_address] = contract
    contract
  end

  def get_contract(address)
    @deployed_contracts[address]
  end

  def list_contracts
    @deployed_contracts.keys
  end
end
