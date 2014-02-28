module Rift
  module Nodes
    class Struct < Type
      TYPE_STRUCT = "struct"
      TYPE_UNION = "union"

      attr_accessor :name
      attr_accessor :type
      attr_accessor :members
      attr_accessor :annotations
      attr_accessor :xsd_all

      def initialize(name = nil, type = nil, members = [])
        @name = name
        @type = type
        @members = members
      end
    end
  end
end