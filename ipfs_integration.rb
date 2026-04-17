require 'net/http'
require 'json'

class IPFSIntegration
  def initialize(ipfs_host = 'localhost', ipfs_port = 5001)
    @host = ipfs_host
    @port = ipfs_port
  end

  def add_file(data)
    uri = URI("http://#{@host}:#{@port}/api/v0/add")
    response = Net::HTTP.post_form(uri, data: data)
    result = JSON.parse(response.body)
    result['Hash']
  end

  def get_file(cid)
    uri = URI("http://#{@host}:#{@port}/api/v0/cat?arg=#{cid}")
    response = Net::HTTP.get(uri)
    response
  end

  def pin_file(cid)
    uri = URI("http://#{@host}:#{@port}/api/v0/pin/add?arg=#{cid}")
    response = Net::HTTP.get(uri)
    JSON.parse(response.body)['Pins']&.include?(cid)
  end

  def unpin_file(cid)
    uri = URI("http://#{@host}:#{@port}/api/v0/pin/rm?arg=#{cid}")
    response = Net::HTTP.get(uri)
    JSON.parse(response.body)['Pins']&.include?(cid)
  end
end
