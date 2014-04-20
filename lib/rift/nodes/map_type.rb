module Rift
  module Nodes
    class MapType < Container
      attr_accessor :key_type
      attr_accessor :value_type

      def initialize(key_type, value_type)
        @key_type = key_type
        @value_type = value_type
      end

      def accept(visitor)
        key_type.accept(visitor) unless key_type.nil?
        value_type.accept(visitor) unless value_type.nil?
        visitor.visit(self)
      end
    end
  end
end