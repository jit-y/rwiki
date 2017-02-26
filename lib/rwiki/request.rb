module Rwiki
  class Request
    using Rwiki::Extension
    attr_reader :conn, :options, :query
    def initialize(conn, **options)
      @conn = conn
      @options = options
      @query = query
    end

    def call
      raise NotImplementedError
    end

    def query
      raise NotImplementedError
    end
  end
end
