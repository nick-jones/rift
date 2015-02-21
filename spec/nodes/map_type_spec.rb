require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:key_type) { double('FieldType') }
  let(:value_type) { double('FieldType') }
  let(:node) { Rift::Nodes::MapType.new(key_type, value_type) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(key_type).to receive(:accept)
      allow(value_type).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(key_type).to have_received(:accept).with(visitor).once
      expect(value_type).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end