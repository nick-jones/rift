require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining a typedef" do
  let(:parser) { Rift::Parser.new }

  context "with a base type of i32" do
    it {
      expect(parser.parse("typedef i32 X")).to equal_tree "spec/fixtures/typedef/base_type.yml"
    }
  end

  context "with a container type of map" do
    it {
      expect(parser.parse("typedef map<i32,i32> X")).to equal_tree "spec/fixtures/typedef/container_type.yml"
    }
  end

  context "with an identifier resolvable type" do
    it {
      expect(parser.parse("typedef Y X")).to equal_tree "spec/fixtures/typedef/identifier.yml"
    }
  end

  context "with an invalid type '1'" do
    it {
      expect {
        parser.parse("typedef 1 X'")
      }.to raise_error "Unexpected token CONSTANT_INT '1' on line 1"
    }
  end
end