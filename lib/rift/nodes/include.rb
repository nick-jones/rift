module Rift
  module Nodes
    class Include < Node
      attr_accessor :path

      def initialize(path)
        @path = path
      end
    end
  end
end