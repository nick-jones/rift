require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:type) { double('FieldType') }
  let(:node) { Rift::Nodes::Typedef.new(type, nil) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(type).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(type).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end