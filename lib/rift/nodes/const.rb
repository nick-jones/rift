module Rift
  module Nodes
    class Const < Node
      attr_accessor :type
      attr_accessor :name
      attr_accessor :value

      def initialize(type, name, value)
        @type = type
        @name = name
        @value = value
      end

      def accept(visitor)
        type.accept(visitor) unless type.nil?
        value.accept(visitor) unless value.nil?
        visitor.visit(self)
      end
    end
  end
end