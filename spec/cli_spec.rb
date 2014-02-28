require "spec_helper"
require "rift/cli"

describe Rift::CLI do
  class StubParser
    def parse(source)
      ""
    end
  end

  context "when no file path is supplied" do
    it {
      expect {
        Rift::CLI.run([])
      }.to raise_error "A file path must be supplied"
    }
  end

  context "when the file path does not exist" do
    it {
      expect {
        Rift::CLI.run([".__null__."])
      }.to raise_error "A valid file path must be supplied"
    }
  end

  context "when a valid thrift file is supplied" do
    it "should output a YAML representation of the equivalent syntax tree" do
      $stdout.should_receive(:puts).with("--- \"\"\n")
      Rift::CLI.run(["spec/fixtures/empty.thrift"], StubParser.new)
    end
  end
end