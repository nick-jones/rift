require "spec_helper"
require "rift/parser"

describe Rift::Parser, "when defining a service" do
  let(:parser) { Rift::Parser.new }

  context "with no functions" do
    it {
      expression = "service X { }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/empty.yml"
    }
  end

  context "with typical returning functions" do
    it {
      expression = "service X { bool a(1: i32 x), Test b(1: Foo y, 2: i32 z) }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/standard_functions.yml"
    }
  end

  context "with a function indicated as oneway" do
    it {
      expression = "service X { oneway bool a(1: i32 x) }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/oneway_function.yml"
    }
  end

  context "with it extending another service" do
    it {
      expression = "service X extends Y { }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/extended.yml"
    }
  end

  context "with a function declaring exceptions that could be thrown" do
    it {
      expression = "service X { bool a() throws (1: XException xe, 2: YException ye) }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/throwing_function.yml"
    }
  end

  context "with a function indicating no return type" do
    it {
      expression = "service X { void a() }"
      expect(parser.parse(expression)).to equal_tree "spec/fixtures/service/void_function.yml"
    }
  end
end