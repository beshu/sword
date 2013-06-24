# encoding: utf-8
require './' + File.dirname(__FILE__) + '/lib/sword'

Gem::Specification.new do |s|
  s.name = 'sword'
  s.version = Sword::VERSION
  
  s.authors = 'George'
  s.email = 'somu@so.mu'
  s.homepage = 'http://github.com/somu/sword'

  s.files = `git ls-files`.split("\n") - %w[.gitignore .travis.yml sword.sublime-project sword.exe compile.bat icon.ico]
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename f }

  s.add_runtime_dependency 'sinatra', '>= 1.3.2'
  s.required_ruby_version = '>= 1.8.7'

  s.license = 'MIT'
  s.summary = 'Designer’s best friend forever'
  s.description = 'Develop using SASS/Compass, Slim, LESS &c. and convert it to static'
end
