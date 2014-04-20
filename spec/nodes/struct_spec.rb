require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:member) { double('Field') }
  let(:node) { Rift::Nodes::Struct.new(nil, nil, [member]) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(member).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(member).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end