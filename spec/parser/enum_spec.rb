require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining an enum" do
  let(:parser) { Rift::Parser.new }

  context "with no members" do
    it {
      expect(parser.parse("enum X { }")).to equal_tree "spec/fixtures/enum/empty.yml"
    }
  end

  context "with an non-value assigned member A" do
    it {
      expect(parser.parse("enum X { e10 }")).to equal_tree "spec/fixtures/enum/unassigned_member.yml"
    }
  end

  context "with member A assigned an integer value" do
    it {
      expect(parser.parse("enum X { A=9 }")).to equal_tree "spec/fixtures/enum/integer_assigned_member.yml"
    }
  end

  context "with member A assigned a hex value" do
    it {
      expect(parser.parse("enum X { A=0xC }")).to equal_tree "spec/fixtures/enum/hex_assigned_member.yml"
    }
  end

  context "with member A assigned a bool value" do
    it {
      expect(parser.parse("enum X { A=false }")).to equal_tree "spec/fixtures/enum/bool_assigned_member.yml"
    }
  end

  context "with a member assigned a non-integer castable value" do
    it {
      expect {
        parser.parse("enum X { A='z' }")
      }.to raise_error "Unexpected token LITERAL 'z' on line 1"
    }
  end
end