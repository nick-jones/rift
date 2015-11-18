require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining a namespace" do
  let(:parser) { Rift::Parser.new }

  context "with an identifier supplied as the language" do
    it {
      expect(parser.parse("namespace java com.example")).to equal_tree "spec/fixtures/namespace/identifier.yml"
    }
  end

  context "with a language wildcard" do
    it {
      expect(parser.parse("namespace * example")).to equal_tree "spec/fixtures/namespace/wildcard.yml"
    }
  end

  context "with annotations" do
    it {
      expect(parser.parse("namespace xsd test (uri = 'http://example.com')")).to equal_tree "spec/fixtures/namespace/annotated.yml"
    }
  end

  context "with an invalid language type" do
    it {
      expect {
        parser.parse("namespace 'x' example")
      }.to raise_error "Unexpected token LITERAL 'x' on line 1"
    }
  end
end