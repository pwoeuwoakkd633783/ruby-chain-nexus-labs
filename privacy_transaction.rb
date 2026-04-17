require_relative 'crypto_utils'

class PrivacyTransaction
  def initialize(sender, recipient, amount)
    @sender = sender
    @recipient = recipient
    @amount = amount
    @commitment = generate_commitment
    @nullifier = generate_nullifier
  end

  def generate_commitment
    CryptoUtils.sha256("#{@sender}#{@recipient}#{@amount}#{SecureRandom.hex(8)}")
  end

  def generate_nullifier
    CryptoUtils.sha256("#{@commitment}#{SecureRandom.hex(8)}")
  end

  def to_private_transaction
    {
      commitment: @commitment,
      nullifier: @nullifier,
      encrypted_amount: encrypt_amount,
      timestamp: Time.now.to_i
    }
  end

  private

  def encrypt_amount
    CryptoUtils.base64_encode(@amount.to_s)
  end
end
