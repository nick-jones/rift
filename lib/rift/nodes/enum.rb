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
    end
  end
end