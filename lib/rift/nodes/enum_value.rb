module Rift
  module Nodes
    class EnumValue < Node
      attr_accessor :name
      attr_accessor :value
      attr_accessor :annotations

      def initialize(name, value = nil)
        @name = name
        @value = value
      end
    end
  end
end