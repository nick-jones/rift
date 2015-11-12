require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining a const" do
  let(:parser) { Rift::Parser.new }

  context "with a 8-bit int value 1" do
    it {
      expect(parser.parse("const i8 X = 1")).to equal_tree "spec/fixtures/const/int8.yml"
    }
  end

  context "with a 32-bit int value 1" do
    it {
      expect(parser.parse("const i32 X = 1")).to equal_tree "spec/fixtures/const/int32.yml"
    }
  end

  context "with a negative 32-bit integer value -1" do
    it {
      expect(parser.parse("const i32 X = -1")).to equal_tree "spec/fixtures/const/negative_int32.yml"
    }
  end

  context "with a double value 1.0" do
    it {
      expect(parser.parse("const double X = 1.0")).to equal_tree "spec/fixtures/const/double.yml"
    }
  end

  context "with a negative double value -1.0" do
    it {
      expect(parser.parse("const double X = -1.0")).to equal_tree "spec/fixtures/const/negative_double.yml"
    }
  end

  context "with a hex value 0xA" do
    it {
      expect(parser.parse("const i32 X = 0xA")).to equal_tree "spec/fixtures/const/hex.yml"
    }
  end

  context "with a negative hex value -0xA" do
    it {
      expect(parser.parse("const i32 X = -0xA")).to equal_tree "spec/fixtures/const/negative_hex.yml"
    }
  end

  context "with a string literal value 'z'" do
    it {
      expect(parser.parse("const string X = 'z'")).to equal_tree "spec/fixtures/const/string.yml"
    }
  end

  context "with an identifier named 'z'" do
    it {
      expect(parser.parse("const string X = z")).to equal_tree "spec/fixtures/const/identifier.yml"
    }
  end

  context "with an integer list composed of value [1]" do
    it {
      expect(parser.parse("const list<i32> X = [1]")).to equal_tree "spec/fixtures/const/list.yml"
    }
  end

  context "with an integer:integer map composed of mapping {1: 2}" do
    it {
      expect(parser.parse("const map<i32,i32> X = {1: 2}")).to equal_tree "spec/fixtures/const/map.yml"
    }
  end

  context "with a missing value" do
    it {
      expect {
        parser.parse("const i32 X = ;")
      }.to raise_error "Unexpected token \";\" ';' on line 1"
    }
  end
end