require 'faraday'
require 'nokogiri'

module Faraday
  class Response
    class NokogiriParser < Middleware
      def parse(body)
        Nokogiri::XML(body)
      end
    end
    register_middleware nokogiri: NokogiriParser
  end
end
