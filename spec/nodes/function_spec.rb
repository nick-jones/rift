require "spec_helper"
require "rift/node"
require "rift/nodes"

describe Rift::Nodes::Const do
  let(:return_type) { double('FieldType') }
  let(:argument) { double('Field') }
  let(:node) { Rift::Nodes::Function.new(return_type, nil, [argument], false) }

  describe "#accept" do
    it "should pass itself and children to visitor" do
      visitor = double('visitor')
      allow(return_type).to receive(:accept)
      allow(argument).to receive(:accept)
      allow(visitor).to receive(:visit)

      exception = Rift::Nodes::Field.new(nil, 'x')
      node.exceptions = [exception]
      node.accept(visitor)
      expect(return_type).to have_received(:accept).with(visitor).once
      expect(argument).to have_received(:accept).with(visitor).once
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end