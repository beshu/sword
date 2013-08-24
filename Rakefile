desc 'Run specs'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

name = 'sword'

desc 'Check documentation coverage'
task :docs do 
  ruby '-S yard stats'
end

task :default => :spec

def compiled_gems
  Dir["./#{name}-*"]
end

def latest_gem
  compiled_gems.sort.last
end

desc 'Compile README'
task :readme do
  $:.unshift File.dirname(__FILE__) << '/lib'
  require 'tilt'
  require 'sword'
  include Sword
  open('README.md', 'w') { |f| f.puts Tilt.new('README.erb').render }
end

desc 'Release a version'
task :release => [:build, :push, :install, :cleanup, :purify]

desc 'Build a gem'
task :build do
  sh "gem build #{name}.gemspec"
end

desc 'Push the latest version to Rubygems'
task :push do
  sh "gem push #{latest_gem}"
end

desc 'Install the latest version'
task :install do
  command = 'gem install '
  command << (compiled_gems.empty? ? name : latest_gem)
  sh command
end

desc 'Deletes all old versions of the gem'
task :cleanup do
  sh "gem cleanup #{name}"
end

desc 'Deletes all compiled gems'
task :purify do
  compiled_gems.each { |f| rm f }
end
