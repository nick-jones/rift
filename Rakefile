require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

desc "Compile the lexer and parser"
task :compile do
  sh "bundle exec rex language/tokenizer.rex -o lib/rift/generated/tokenizer.rb"
  sh "bundle exec racc language/parser.racc -o lib/rift/generated/parser.rb"
end

task :default => :spec