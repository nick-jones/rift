require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:value) { double('BaseType') }
  let(:node) { Rift::Nodes::FieldType.new(nil, value) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(value).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(value).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end