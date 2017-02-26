module Rwiki
  class Query
    DEFAULT_PARAMS = { format: :xml,action: :query }.freeze
    def self.build(&block)
      new(&block).to_query
    end
    using Rwiki::Extension
    attr_reader :params
    def initialize(&block)
      @params = Openstruct.new(DEFAULT_PARAMS)
      block.call(@params)
    end

    def to_query
      params.to_h.to_query
    end
  end
end
