require 'faraday'
require 'faraday_middleware'

module Rwiki
  class Client
    using Rwiki::Extension
    attr_reader :connection, :format_type
    BASE_URL = 'http://ja.wikipedia.org/w/api.php'.freeze

    def self.random(**options)
      new.random(**options)
    end

    def initialize
      @connection = connection
    end

    def test(q)
      query = { format: :xml, action: :query, prop: :revisions, titles: q, rvprop: :content }.to_query
      res = connection.get query
      res.body.slop!
    end

    def random(**options)
      Rwiki::Request::Random.new(connection, **options).call
    end

    private

    def connection
      Faraday.new(url: BASE_URL) do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.adapter :net_http
        conn.response :nokogiri
      end
    end
  end
end
