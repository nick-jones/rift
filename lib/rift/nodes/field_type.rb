module Rift
  module Nodes
    class FieldType < Node
      TYPE_USER_DEFINED = "user_defined"
      TYPE_PRIMITIVE = "primitive"

      attr_accessor :type
      attr_accessor :value

      def initialize(type, value)
        @type = type
        @value = value
      end
    end
  end
end