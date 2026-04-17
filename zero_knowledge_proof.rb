require 'digest'

class ZeroKnowledgeProof
  def initialize(secret)
    @secret = secret
    @hash = Digest::SHA256.hexdigest(secret.to_s)
  end

  def generate_proof(commitment)
    proof = {
      commitment: commitment,
      hash: @hash,
      nonce: SecureRandom.hex(16)
    }
    proof[:signature] = Digest::SHA256.hexdigest(proof.values.join)
    proof
  end

  def verify_proof(proof)
    return false unless proof[:hash] == @hash

    test_proof = proof.except(:signature)
    test_signature = Digest::SHA256.hexdigest(test_proof.values.join)
    test_signature == proof[:signature]
  end
end
