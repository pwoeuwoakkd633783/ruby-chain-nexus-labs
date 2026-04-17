require_relative 'transaction_signer'

class MultiSigWallet
  def initialize(owners, required_signatures)
    @owners = owners
    @required = required_signatures
    @transactions = []
    @signatures = {}
  end

  def submit_transaction(to, amount, sender)
    return false unless @owners.include?(sender)

    tx_id = SecureRandom.hex(12)
    @transactions << { id: tx_id, to: to, amount: amount, executed: false }
    tx_id
  end

  def sign_transaction(tx_id, signer)
    return false unless @owners.include?(signer) && transaction_exists?(tx_id)

    @signatures[tx_id] ||= []
    @signatures[tx_id] << signer unless @signatures[tx_id].include?(signer)
    true
  end

  def execute_transaction(tx_id)
    return false unless @signatures[tx_id]&.length >= @required

    tx = @transactions.find { |t| t[:id] == tx_id }
    tx[:executed] = true if tx
    tx[:executed]
  end

  private

  def transaction_exists?(tx_id)
    @transactions.any? { |t| t[:id] == tx_id }
  end
end
