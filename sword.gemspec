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

  s.license = 'MIT'
  s.summary = 'Designer’s best friend forever'
  s.description = 'Develop using SASS/Compass, Slim, LESS &c. and convert it to static'

  s.add_dependency 'sinatra', '~> 1'
end