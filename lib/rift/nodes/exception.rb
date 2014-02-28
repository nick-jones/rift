module Rift
  module Nodes
    class Exception < Node
      attr_accessor :name
      attr_accessor :fields
      attr_accessor :annotations

      def initialize(name, fields = [])
        @name = name
        @fields = fields
      end
    end
  end
end