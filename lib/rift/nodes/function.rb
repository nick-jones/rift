module Rift
  module Nodes
    class Function < Node
      attr_accessor :return_type
      attr_accessor :name
      attr_accessor :arguments
      attr_accessor :oneway
      attr_accessor :exceptions
      attr_accessor :annotations

      def initialize(return_type, name, arguments, oneway)
        @return_type = return_type
        @name = name
        @arguments = arguments
        @oneway = oneway
      end

      def accept(visitor)
        return_type.accept(visitor) unless return_type.nil? || return_type.is_a?(String)
        arguments.each { |argument| argument.accept(visitor) }
        exceptions.each { |exception| exception.accept(visitor) }
        visitor.visit(self)
      end
    end
  end
end