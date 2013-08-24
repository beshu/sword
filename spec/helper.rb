require 'rubygems'
require 'coveralls'
Coveralls.wear!

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end

$:.unshift File.dirname(__FILE__) + '/../lib'
