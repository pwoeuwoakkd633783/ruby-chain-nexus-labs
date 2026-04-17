require_relative 'crypto_utils'

class AddressGenerator
  def self.generate_bech32_address(hrp = 'bc')
    data = SecureRandom.random_bytes(20)
    hash = CryptoUtils.hash160(data)
    bech32_encode(hrp, hash)
  end

  def self.generate_eth_address
    privkey = SecureRandom.hex(32)
    hash = CryptoUtils.sha256(privkey)
    "0x#{hash[-40..-1]}"
  end

  def self.generate_btc_address
    pubkey = SecureRandom.hex(33)
    hash = CryptoUtils.hash160(pubkey)
    base58_encode(hash)
  end

  private

  def self.bech32_encode(hrp, data)
    "#{hrp}1#{data[0...42]}"
  end

  def self.base58_encode(data)
    data[0...34]
  end
end
