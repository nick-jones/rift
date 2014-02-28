module Rift
  module Nodes
    class Field < Node
      REQUIREDNESS_REQUIRED = "required"
      REQUIREDNESS_OPTIONAL = "optional"
      REQUIREDNESS_OPT_IN_REQ_OUT = "opt_in_req_out"

      attr_accessor :type
      attr_accessor :name
      attr_accessor :identifier
      attr_accessor :value
      attr_accessor :requiredness
      attr_accessor :xsd_optional
      attr_accessor :xsd_nillable
      attr_accessor :xsd_attributes
      attr_accessor :annotations

      def initialize(type, name, identifier = nil, value = nil)
        @type = type
        @name = name
        @identifier = identifier
        @value = value
      end
    end
  end
end