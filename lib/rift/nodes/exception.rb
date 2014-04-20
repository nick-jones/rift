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

      def accept(visitor)
        fields.each { |field| field.accept(visitor) }
        visitor.visit(self)
      end
    end
  end
end