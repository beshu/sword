require 'ostruct'

module Sword
  Environment = OpenStruct.new
  Environment.directory = '.'

  # Configuration setup
  Environment.templates = {}
  Environment.gems = {}

  Environment.template_lists = Dir[File.dirname(__FILE__) << '../templates']
  Environment.gem_lists      = Dir[File.dirname(__FILE__) << '../gems']
end