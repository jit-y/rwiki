module Rwiki
  module Request
    class Random
      using Rwiki::Extension
      attr_reader :options, :conn

      def initialize(conn, **options)
        @conn = conn
        @options = options
      end

      def call
        limit = options.delete(:limit) || 5
        namespace = options.delete(:namespace) || 0
        query = { format: :xml, action: :query, list: :random, rnamespace: namespace, rnlimit: limit }.to_query
        res = conn.get query
        res.body
      end
    end
  end
end
