module Rwiki
  module Requests
    class Random < Rwiki::Request
      using Rwiki::Extension
      attr_reader :options, :conn

      def call
        res = conn.get query
        res.body
      end

      def query
        limit = options.delete(:limit) || 5
        namespace = options.delete(:namespace) || 0
        Rwiki::Query.build do |q|
          q.list = :random
          q.rnnamespace = namespace
          q.rnlimit = limit
        end
      end
    end
  end
end
