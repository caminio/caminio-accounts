require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require File::expand_path '../rake_task', __FILE__
Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new('spec')

Dir.glob('lib/tasks/*.rake').each { |r| load r}

# If you want to make this the default task
task :default => :spec

