require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:function) { double('Function') }
  let(:node) { Rift::Nodes::Service.new(nil, nil, [function]) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(function).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(function).to have_received(:accept).with(visitor)
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end