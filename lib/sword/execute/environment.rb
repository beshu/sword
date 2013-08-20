require 'ostruct'
require 'yaml'

module Sword
  module Execute
    Environment = OpenStruct.new

    # Configuration setup
    Environment.templates = {}
    Environment.gems = {}

    Environment.template_lists = Dir[File.dirname(__FILE__) << '../templates']
    Environment.gem_lists      = Dir[File.dirname(__FILE__) << '../gems']
  end
end