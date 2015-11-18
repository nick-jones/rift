module Rift
  module Nodes
    class Namespace < Node
      attr_accessor :language
      attr_accessor :value
      attr_accessor :annotations

      def initialize(language, value)
        @language = language
        @value = value
      end
    end
  end
end