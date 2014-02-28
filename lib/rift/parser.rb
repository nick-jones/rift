require "rift/generated/parser"
require "rift/parse_error"
require "rift/node"
require "rift/nodes"

module Rift
  class Parser < Rift::Generated::Parser
    # Parses a thrift IDL for an abstract syntax tree.
    def parse(source)
      @nodes = []
      scan_str(source)
      @nodes
    end

    # Error function hook called by Racc.
    def on_error(token, error, value_stack)
      value = token_to_str(token)
      message = "Unexpected token #{value} '#{error}' on line #{@lineno.to_s}"

      raise Rift::ParseError, message
    end
  end
end