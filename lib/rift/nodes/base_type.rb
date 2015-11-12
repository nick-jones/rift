module Rift
  module Nodes
    class BaseType < Type
      TYPE_VOID = "void"
      TYPE_STRING = "string"
      TYPE_BOOL = "bool"
      TYPE_I8 = "i8"
      TYPE_I16 = "i16"
      TYPE_I32 = "i32"
      TYPE_I64 = "i64"
      TYPE_DOUBLE = "double"
      TYPE_BINARY = "binary"

      attr_accessor :type
      attr_accessor :annotations

      def initialize(type)
        @type = type
      end
    end
  end
end