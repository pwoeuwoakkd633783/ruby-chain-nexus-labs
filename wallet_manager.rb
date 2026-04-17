require_relative 'transaction_signer'

class WalletManager
  attr_reader :address, :key_pair

  def initialize
    @signer = TransactionSigner.new
    @key_pair = @signer.generate_key_pair
    @address = generate_wallet_address
  end

  def generate_wallet_address
    Digest::SHA256.hexdigest(@key_pair[:public_key])[0...42]
  end

  def create_transaction(recipient, amount)
    transaction = {
      sender: @address,
      recipient: recipient,
      amount: amount,
      timestamp: Time.now.to_i
    }
    signature = @signer.sign_transaction(transaction, @key_pair[:private_key])
    { transaction: transaction, signature: signature }
  end

  def get_balance(blockchain)
    balance = 0
    blockchain.chain.each do |block|
      block[:transactions].each do |tx|
        balance += tx[:amount] if tx[:recipient] == @address
        balance -= tx[:amount] if tx[:sender] == @address
      end
    end
    balance
  end
end
