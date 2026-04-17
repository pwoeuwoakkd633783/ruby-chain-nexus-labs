require 'json'
require 'msgpack'

class BlockSerializer
  def self.to_json(block)
    JSON.generate(block)
  end

  def self.from_json(json_data)
    JSON.parse(json_data, symbolize_names: true)
  end

  def self.to_msgpack(block)
    MessagePack.pack(block)
  end

  def self.from_msgpack(data)
    MessagePack.unpack(data)
  end

  def self.compress_block(block)
    json_data = to_json(block)
    Zlib::Deflate.deflate(json_data)
  end

  def self.decompress_block(data)
    json_data = Zlib::Inflate.inflate(data)
    from_json(json_data)
  end
end
