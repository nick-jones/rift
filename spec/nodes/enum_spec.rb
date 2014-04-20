require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:enum_value) { double('EnumValue') }
  let(:node) { Rift::Nodes::Enum.new(nil, [enum_value]) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(enum_value).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(enum_value).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end