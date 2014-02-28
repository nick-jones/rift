module Rift
  module Nodes
    class ListType < Container
      attr_accessor :element_type

      def initialize(element_type)
        @element_type = element_type
      end
    end
  end
end