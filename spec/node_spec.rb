require "spec_helper"
require "rift/node"

describe Rift::Node do
  class TestNode < Rift::Node
    attr_accessor :value
    attr_accessor :children

    def initialize(value = nil, children = [])
      @value = value
      @children = children
    end
  end

  let(:node) { TestNode.new(1, [TestNode.new(2)]) }

  describe ".==" do
    context "with identical instances" do
      it "returns true" do
        expect(node).to eq(node)
      end
    end

    context "with instances containing equivalent values" do
      it "returns true" do
        other = TestNode.new(1, [TestNode.new(2)])
        expect(node).to eq(other)
      end
    end

    context "with instances containing non-equivalent values" do
      it "returns false" do
        other = TestNode.new 2
        expect(node).not_to eq(other)
      end
    end

    context "with instances containing non-equivalent children" do
      it "returns false" do
        other = TestNode.new(1, [TestNode.new(3)])
        expect(node).not_to eq(other)
      end
    end
  end

  describe "to_a" do
    it "should convert the node into an array representation" do
      expected = [[:@value, 1], [:@children, [[[:@value, 2], [:@children, []]]]]]
      expect(node.to_a).to eq(expected)
    end

    it "should traverse nested arrays" do
      node = TestNode.new(1, [[TestNode.new(2)]])
      expected = [[:@value, 1], [:@children, [[[[:@value, 2], [:@children, []]]]]]]
      expect(node.to_a).to eq(expected)
    end
  end

  describe "#accept" do
    it "should pass itself to the visitor" do
      visitor = double('Visitor')
      allow(visitor).to receive(:visit)

      node.accept(visitor)
      expect(visitor).to have_received(:visit).with(node).once
    end
  end
end