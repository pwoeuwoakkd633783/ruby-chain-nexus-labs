require 'net/http'
require 'json'

class OracleFeed
  def initialize
    @data_sources = []
    @latest_data = {}
  end

  def add_data_source(url)
    @data_sources << url unless @data_sources.include?(url)
  end

  def fetch_price(symbol)
    responses = []
    @data_sources.each do |source|
      data = fetch_from_source(source, symbol)
      responses << data[:price] if data
    end
    return nil if responses.empty?

    @latest_data[symbol] = responses.sum / responses.length
    @latest_data[symbol]
  end

  def get_latest_price(symbol)
    @latest_data[symbol]
  end

  private

  def fetch_from_source(url, symbol)
    uri = URI("#{url}?symbol=#{symbol}")
    response = Net::HTTP.get(uri)
    JSON.parse(response, symbolize_names: true)
  rescue StandardError
    nil
  end
end
