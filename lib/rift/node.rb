require "pp"

module Rift
  class Node
    # Simple accept implementation. Nodes that enumerate other nodes must override this.
    def accept(visitor)
      visitor.visit(self)
    end

    # As the nodes are "pure" at the moment, we can simply compare classname + instance variables. If
    # internal only instance variables are ever added, this will need rethinking. Furthermore, as this
    # results in the entire tree being converted to an array, using a visitor may be more suitable.
    def ==(other)
      self.class == other.class &&
        to_a == other.to_a
    end

    # Returns an array where each element is an array pair. The first element is the instance variable
    # name, and the second is its value.
    def to_a
      nodes = instance_variables.map { |v| [v, instance_variable_get(v)] }
      nodes_to_a nodes
    end

    protected

    # Converts the supplied nodes into an equivalent array based representation. It does this in a
    # recursive fashion.
    def nodes_to_a nodes
      if nodes.respond_to?(:to_a)
        nodes = nodes.to_a.map { |node| nodes_to_a node }
      end

      nodes
    end
  end
end