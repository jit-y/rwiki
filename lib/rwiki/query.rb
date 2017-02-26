module Rwiki
  class Query
    using Rwiki::Extension
    DEFAULT_PARAMS = { format: :xml, action: :query }.freeze
    attr_reader :params

    def self.build(&block)
      new(&block).to_query
    end

    def initialize(&block)
      @params = Openstruct.new(DEFAULT_PARAMS)
      block.call(@params)
    end

    def to_query
      params.to_h.to_query
    end
  end
end
