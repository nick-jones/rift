module Rift
  module Nodes
    class MapType < Container
      attr_accessor :key_type
      attr_accessor :value_type

      def initialize(key_type, value_type)
        @key_type = key_type
        @value_type = value_type
      end
    end
  end
end