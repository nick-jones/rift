module Rift
  module Nodes
    class Typedef < Type
      attr_accessor :type
      attr_accessor :symbolic
      attr_accessor :annotations

      def initialize(type, symbolic, annotations = nil)
        @type = type
        @symbolic = symbolic
        @annotations = annotations
      end
    end
  end
end