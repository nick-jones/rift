require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:field_type) { double('FieldType') }
  let(:const_value) { double('ConstValue') }
  let(:node) { Rift::Nodes::Const.new(field_type, '', const_value) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(field_type).to receive(:accept)
      allow(const_value).to receive(:accept)
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(field_type).to have_received(:accept).with(visitor).once
      expect(const_value).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end