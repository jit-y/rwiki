require 'cgi'
module Rwiki
  module Extension
    refine Hash do
      def to_query(prefix = '?')
        query = map do |key, value|
          "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
        end.compact.sort! * '&'
        "#{prefix.to_s}#{query}"
      end
    end
  end
end
