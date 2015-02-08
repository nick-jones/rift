require "yaml"
require "rspec/mocks"
require "coveralls"

Coveralls.wear!

RSpec.configure do |config|
  config.order = 'random'
end

RSpec::Matchers.define :equal_tree do |expected|
  match do |actual|
    @nodes = YAML::load_file(expected)
    @nodes == actual
  end

  description do
    "be equivalent to the syntax tree serialized in \"#{expected}\""
  end
end