module Rift
  module Nodes
    class SetType < Container
      attr_accessor :element_type

      def initialize(element_type)
        @element_type = element_type
      end
    end
  end
end