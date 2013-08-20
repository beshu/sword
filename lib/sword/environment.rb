require 'ostruct'

module Sword
  Environment = OpenStruct.new
  
  Environment.directory = '.'
  Environment.templates = {}
  Environment.gems = []
  Environment.port = 1111

  Environment.library = File.dirname File.dirname(__FILE__)
  Environment.compass = Environment.library + '/compass.rb'
  Environment.favicon = Environment.library + '/favicon.ico'
  Environment.error   = Environment.library + '/error.erb'

  Environment.template_lists = Dir[Environment.library + '/templates/*.yml']
  Environment.gem_lists      = Dir[Environment.library + '/gems/*.yml']

  Environment.settings   = Dir.home + '/.swordrc'
  Environment.local_gems = Dir.home + '/.swordgems'

  def Environment.load(path)
    instance_eval File.read(path)
  end
end