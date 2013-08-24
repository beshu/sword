# This Gemfile is used for testing via Travis CI and
# compiling Windows version using OCRA:
source 'https://rubygems.org'
gemspec

group :test do
  gem 'rack-test', '~> 0.6'
  gem 'rake', '~> 10.1'
  gem 'rspec', '~> 2.14'
  gem 'coveralls'
end

group :ocra do
  gem 'compass'
  gem 'slim'
  gem 'haml'

  # JS environment required
  gem 'coffee-script'
  gem 'stylus'
end
