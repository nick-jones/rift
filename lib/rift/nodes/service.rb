module Rift
  module Nodes
    class Service < Type
      attr_accessor :name
      attr_accessor :extends
      attr_accessor :functions
      attr_accessor :annotations

      def initialize(name, extends = nil, functions = [])
        @name = name
        @extends = extends
        @functions = functions
      end
    end
  end
end