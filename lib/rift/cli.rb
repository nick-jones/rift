require "yaml"
require "rift/parser"

module Rift
  class CLI
    # Entry point for executing CLI commands.
    def self.run(arguments, parser = Rift::Parser.new)
      file_path = arguments[0]
      raise "A file path must be supplied" unless file_path

      exists = File.exist?(file_path)
      raise "A valid file path must be supplied" unless exists

      file = File.open(file_path, "rb")
      nodes = parser.parse(file.read)

      $stdout.puts nodes.to_yaml
    end
  end
end