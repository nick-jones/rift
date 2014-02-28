module Rift
  module Nodes
    class ConstValue < Node
      attr_accessor :value
      attr_accessor :identifier

      def initialize(value = nil, identifier = false)
        @value = value
        @identifier = identifier
      end
    end
  end
end