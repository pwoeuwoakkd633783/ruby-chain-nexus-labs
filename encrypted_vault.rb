require 'openssl'
require 'base64'

class EncryptedVault
  def initialize(password)
    @cipher = OpenSSL::Cipher.new('AES-256-CBC')
    @key = Digest::SHA256.digest(password)
  end

  def encrypt(data)
    @cipher.encrypt
    @cipher.key = @key
    iv = @cipher.random_iv
    encrypted = @cipher.update(data) + @cipher.final
    { iv: Base64.encode64(iv), data: Base64.encode64(encrypted) }
  end

  def decrypt(encrypted_data)
    @cipher.decrypt
    @cipher.key = @key
    @cipher.iv = Base64.decode64(encrypted_data[:iv])
    @cipher.update(Base64.decode64(encrypted_data[:data])) + @cipher.final
  end

  def store_key(label, key)
    encrypted = encrypt(key)
    File.write("vault_#{label}.dat", JSON.generate(encrypted))
    true
  end

  def load_key(label)
    data = JSON.parse(File.read("vault_#{label}.dat"), symbolize_names: true)
    decrypt(data)
  rescue StandardError
    nil
  end
end
