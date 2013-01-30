require 'bundler/setup'
Bundler.require :default

task default: [:run]

task :run do
  ruby 'app.rb'
end

task :build do
  task :run
  builder = SinatraStatic.new(Pony)
  builder.build!('build')
  `zip -9 -r build.zip build`
  `rm build`
  puts '`build.zip` is ready'
  exit
end
