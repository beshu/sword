task :default => [:test]

desc 'Run test suite'
task :test do
  require 'rubygems'
  require 'rspec/autorun'
  require 'rspec'
  require 'rack/test'

  require './lib/sword'
  Dir['./test/*.rb'].each { |t| require t.chomp '.rb' }
end

def compiled_gems
  Dir['./sword-*']
end

def latest_gem
  compiled_gems.sort.last
end

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
  sh command << latest_gem ? latest_gem : 'sword'
end

desc 'Deletes all old versions of the gem'
task :cleanup do
  sh 'gem cleanup sword'
end

desc 'Deletes all compiled gems'
task :purify do
  compiled_gems.each { |f| rm f }
end
