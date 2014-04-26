module Rift
  module Nodes
    class Typedef < Type
      attr_accessor :type
      attr_accessor :symbolic
      attr_accessor :annotations

      def initialize(type, symbolic)
        @type = type
        @symbolic = symbolic
      end

      def accept(visitor)
        type.accept(visitor) unless type.nil?
        visitor.visit(self)
      end
    end
  end
end