require 'ostruct'

module Sword
  Environment = OpenStruct.new
  
  Environment.directory = '.'
  Environment.templates = []
  Environment.gems = []
  Environment.port = 1111

  Environment.library = File.dirname File.dirname(__FILE__)
  Environment.favicon = Environment.library + '/favicon.ico'
  Environment.error   = Environment.library + '/error.erb'

  Environment.template_lists = Dir[Environment.library + '/templates/*.yml']
  Environment.gem_lists      = Dir[Environment.library + '/gems/*.yml']

  Environment.settings_file  = Dir.home + '/.swordrc'
  Environment.local_gem_list = Dir.home + '/.swordgems'

  def Environment.load(path)
    instance_eval File.read(path)
  end
end