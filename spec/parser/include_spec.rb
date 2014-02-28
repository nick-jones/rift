require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when including a thrift IDL file" do
  let(:parser) { Rift::Parser.new }

  context "with a string literal path" do
    it {
      expect(parser.parse("include 'test.thrift'")).to equal_tree "spec/fixtures/include/string.yml"
    }
  end

  context "with a non-string literal path" do
    it {
      expect {
        parser.parse("include x")
      }.to raise_error "Unexpected token IDENTIFIER 'x' on line 1"
    }
  end
end