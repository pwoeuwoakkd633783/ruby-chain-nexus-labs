require 'openssl'
require 'base64'

class TransactionSigner
  def generate_key_pair
    key = OpenSSL::PKey::RSA.new(2048)
    {
      private_key: key.to_pem,
      public_key: key.public_key.to_pem
    }
  end

  def sign_transaction(transaction, private_key_pem)
    private_key = OpenSSL::PKey::RSA.new(private_key_pem)
    data = JSON.dump(transaction.sort.to_h)
    signature = private_key.sign(OpenSSL::Digest.new('SHA256'), data)
    Base64.encode64(signature)
  end

  def verify_signature(transaction, signature, public_key_pem)
    public_key = OpenSSL::PKey::RSA.new(public_key_pem)
    data = JSON.dump(transaction.sort.to_h)
    decoded_signature = Base64.decode64(signature)
    public_key.verify(OpenSSL::Digest.new('SHA256'), decoded_signature, data)
  end
end
