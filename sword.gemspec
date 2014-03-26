# coding: utf-8
require File.dirname(__FILE__) << '/lib/sword/version'

Gem::Specification.new do |s|
  s.name = 'sword'
  s.version = Sword::VERSION
  
  s.authors = 'George Timoschenko'
  s.email = 'somu@so.mu'
  s.homepage = 'https://github.com/somu/sword'

  s.files = Dir['lib/**/*']
  s.executables = 'sword'

  s.license = 'MIT'
  s.summary = 'Rack-based static web server with built-in preprocessing'
  s.description = s.summary
end
