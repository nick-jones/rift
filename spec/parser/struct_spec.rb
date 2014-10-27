require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining a struct" do
  let(:parser) { Rift::Parser.new }

  context "with no members" do
    it {
      expect(parser.parse("struct X { }")).to equal_tree "spec/fixtures/struct/empty.yml"
    }
  end

  context "with members of base type of i32" do
    it {
      expression = "struct X { 1: required i32 a; 2: required i32 b = 2; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/base_type.yml"
    }
  end

  context "with members of container type of map" do
    it {
      expression = "struct X { 1: required map<i32,i32> a; 2: required map<i32,i32> b = {1: 2}; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/container_type.yml"
    }
  end

  context "with members of an identifier resolvable type" do
    it {
      expression = "struct X { 1: required Test a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/identifier.yml"
    }
  end

  context "with members of the declared struct" do
    it {
      expression = "struct X { 1: required X a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/recursive.yml"
    }
  end

  context "with members of the declared struct indicated as references" do
    it {
      expression = "struct X { 1: required X & a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/recursive_reference.yml"
    }
  end

  context "with some members lacking field identifiers" do
    it {
      expression = "struct X { required i32 a; required i32 b; 4: required i32 c; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/lacking_field_identifier.yml"
    }
  end

  context "with optional members" do
    it {
      expression = "struct X { 1: optional i32 a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/optional.yml"
    }
  end

  context "with optional members" do
    it {
      expression = "union X { 1: optional i32 a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/union.yml"
    }
  end

  context "with members containing unspecified requiredness" do
    it {
      expression = "struct X { 1: i32 a; }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/struct/unspecified_requiredness.yml"
    }
  end

  context "with a member using invalid type '1'" do
    it {
      expect {
        parser.parse("struct A { 1: required 1 a; }'")
      }.to raise_error "Unexpected token CONSTANT_INT '1' on line 1"
    }
  end
end