require 'faraday'
require 'faraday_middleware'
module Rwiki
  class Client
    attr_reader :connection, :format_type
    BASE_URL = 'http://ja.wikipedia.org/w/api.php'.freeze
    def initialize(format_type: :json)
      @connection = connection
      @format_type = format_type || :json
    end

    def test(q:)
      connection.get "?format=#{format_type}&action=query&prop=revisions&titles=#{q}&rvprop=content"
    end

    private

    def connection
      Faraday.new(url: BASE_URL) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.request :url_encoded
        conn.adapter :net_http
        conn.response :json
      end
    end
  end
end
