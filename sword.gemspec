# encoding: utf-8
require File.dirname(__FILE__) + '/lib/sword/version'

Gem::Specification.new do |s|
  s.name = 'sword'
  s.version = Sword::VERSION
  
  s.authors = 'George'
  s.email = 'somu@so.mu'
  s.homepage = 'http://github.com/somu/sword'

  s.files = Dir['lib/**/*']
  s.executables = 'sword'

  s.add_runtime_dependency 'sinatra', '>= 1.3.2'
  s.required_ruby_version = '>= 1.8.7'

  s.license = 'MIT'
  s.summary = 'Designer’s best friend forever'
  s.description = 'Develop using SASS/Compass, Slim, LESS &c. and convert it to static'
end
