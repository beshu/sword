require 'ostruct'

module Sword
  Environment = OpenStruct.new
  
  Environment.directory = '.'
  Environment.templates = {}
  Environment.gems = {}
  Environment.library = File.dirname(__FILE__)

  Environment.template_lists = Dir[Environment.library + '/templates']
  Environment.gem_lists      = Dir[Environment.library + '/gems']

  def Environment.load(path)
    instance_eval File.read(path)
  end
end