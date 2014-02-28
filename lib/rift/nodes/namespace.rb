module Rift
  module Nodes
    class Namespace < Node
      attr_accessor :language
      attr_accessor :value

      def initialize(language, value)
        @language = language
        @value = value
      end
    end
  end
end