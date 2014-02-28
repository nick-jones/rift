require "spec_helper"
require "rift/parser"

describe Rift::Parser do
  let(:parser) { Rift::Parser.new }

  describe ".on_error" do
    it "raises an parse error" do
      expect {
        parser.on_error(3, 'a', [])
      }.to raise_error "Unexpected token IDENTIFIER 'a' on line "
    end
  end

  describe ".parse" do
    context "with an empty string" do
      it "return an empty array" do
        expect(parser.parse("")).to be_empty
      end
    end

    context "with valid thrift IDL" do
      it "return a syntax tree" do
        expect(parser.parse("struct X { }")).to have(1).items
      end
    end

    context "with invalid thrift IDL" do
      it "should raise an error" do
        expect {
          parser.parse("a")
        }.to raise_error "Unexpected token IDENTIFIER 'a' on line 1"
      end
    end

    it "should permit comments" do
      expression = <<-eos
        // comment
        struct X { /* comment */ }
        # comment
        /**
         * comment
         */
        struct Y { 1: required /*comment */ i32 x; }
      eos

      expect(parser.parse(expression)).to have(2).items
    end
  end
end