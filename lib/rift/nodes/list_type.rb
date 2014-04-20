module Rift
  module Nodes
    class ListType < Container
      attr_accessor :element_type

      def initialize(element_type)
        @element_type = element_type
      end

      def accept(visitor)
        element_type.accept(visitor) unless element_type.nil?
        visitor.visit(self)
      end
    end
  end
end