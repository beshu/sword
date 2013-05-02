source 'https://rubygems.org'
require 'yaml'

YAML.load_file(Dir.pwd + '/lib/parsing.yml')['gems'].each do |g|
  gem(g.instance_of?(Hash) ? g.values[0].first : g)
end

gemspec
