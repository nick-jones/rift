module Rift
  module Nodes
    class Enum < Type
      attr_accessor :name
      attr_accessor :values
      attr_accessor :annotations

      def initialize(name = nil, values = [])
        @name = name
        @values = values
      end

      def accept(visitor)
        values.each { |value| value.accept(visitor) }
        visitor.visit(self)
      end
    end
  end
end