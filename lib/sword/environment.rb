require 'ostruct'

module Sword
  Environment = OpenStruct.new
  E = Environment

  def Environment.configure(&block)
    yield self
  end

  Environment.configure do |e|
    e.directory = '.'
    e.templates = {}
    e.gems = []
    e.port = 1111

    e.library = File.dirname File.dirname(__FILE__)
    e.compass = e.library + '/compass.rb'
    e.favicon = e.library + '/favicon.ico'
    e.error   = e.library + '/error.erb'

    e.template_lists = Dir["#{e.library}/templates/*.yml"]
    e.gem_lists      = Dir["#{e.library}/gems/*.yml"]

    e.home = Dir.home if Dir.respond_to? :home
    e.home ||= ENV['HOME']

    e.local_gems = e.home + '/.swordgems'
    e.settings   = e.home + '/.swordrc'
  end
end