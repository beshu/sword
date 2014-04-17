$:.unshift File.dirname(__FILE__) << '/lib'
require 'bundler/gem_tasks'
task :default => :test

desc 'Tests if Sword works'
task :test do
  test_dir = '/tmp/sword-test'
  require 'sword/cli'

  begin
    mkdir test_dir
    cd test_dir do
      open('hi.erb', 'w') { |f| f.print '<p><%= RUBY_VERSION %></p>' }
      Sword::CLI.new ['-c']
      raise RuntimeError unless File.read('hi.html')["<p>#{RUBY_VERSION}</p>"]
    end
  ensure
    rm_rf test_dir
  end
end
