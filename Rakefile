Bundler.require :test

RSpec::Core::RakeTask.new(:spec) do
  ENV['coverage'] = "true"
end

task :default => :spec