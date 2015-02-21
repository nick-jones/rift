require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:element_type) { Rift::Nodes::FieldType.new(nil, nil) }
  let(:node) { Rift::Nodes::SetType.new(element_type) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(element_type).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(element_type).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end