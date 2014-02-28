module Rift
  module Nodes
    class FieldIdentifier < Node
      attr_accessor :value
      attr_accessor :auto_assigned

      def initialize(value, auto_assigned = false)
        @value = value
        @auto_assigned = auto_assigned
      end
    end
  end
end