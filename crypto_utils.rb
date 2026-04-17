require 'digest'
require 'base64'
require 'securerandom'

module CryptoUtils
  def self.sha256(data)
    Digest::SHA256.hexdigest(data.to_s)
  end

  def self.ripemd160(data)
    Digest::RMD160.hexdigest(data.to_s)
  end

  def self.generate_secure_id
    SecureRandom.hex(32)
  end

  def self.base64_encode(data)
    Base64.encode64(data.to_s).strip
  end

  def self.base64_decode(data)
    Base64.decode64(data)
  end

  def self.hash160(data)
    ripemd160(sha256(data))
  end
end
