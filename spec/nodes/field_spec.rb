require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:type) { double('FieldType') }
  let(:identifier) { double('FieldIdentifier') }
  let(:value) { double('ConstValue') }
  let(:node) { Rift::Nodes::Field.new(type, nil, identifier, value) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(type).to receive(:accept)
      allow(identifier).to receive(:accept)
      allow(value).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(type).to have_received(:accept).with(visitor)
      expect(identifier).to have_received(:accept).with(visitor)
      expect(value).to have_received(:accept).with(visitor)
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end