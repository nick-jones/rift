require "yaml"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end

RSpec::Matchers.define :equal_tree do |expected|
  match do |actual|
    YAML::ENGINE.yamler = 'syck'
    @nodes = YAML::load_file(expected)
    @nodes == actual
  end

  description do
    "be equivalent to the syntax tree serialized in \"#{expected}\""
  end
end