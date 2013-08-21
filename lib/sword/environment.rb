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

  Environment.home = Dir.home if Dir.respond_to? :home
  Environment.home ||= ENV['HOME']

  Environment.settings   = Environment.home + '/.swordrc'
  Environment.local_gems = Environment.home + '/.swordgems'

  def Environment.load(path)
    instance_eval File.read(path)
  end
end