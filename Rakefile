require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

def compiled_gems
  Dir['./sword-*']
end

def latest_gem
  compiled_gems.sort.last
end

desc 'Release a version'
task :release => [:build, :push, :install, :cleanup, :purify]

desc 'Build a gem'
task :build do
  sh 'gem build sword.gemspec'
end

desc 'Push the latest version to Rubygems'
task :push do
  sh "gem push #{latest_gem}"
end

desc 'Install the latest version'
task :install do
  command = 'gem install '
  command << (compiled_gems.empty? ? 'sword' : latest_gem)
  sh command
end

desc 'Deletes all old versions of the gem'
task :cleanup do
  sh 'gem cleanup sword'
end

desc 'Deletes all compiled gems'
task :purify do
  compiled_gems.each { |f| rm f }
end
