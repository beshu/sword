require 'optparse'
require 'sword'
require 'sword/patch'

module Sword::CLI
  DEFAULTS = {:Port => 1111}
  @options = []

  class << self
    def new(arguments = ARGV)
      Sword._
      @settings = DEFAULTS
      OptionParser.new { |op| @options.sort.each { |p| op.on(*p) } }.parse(arguments)
      Rack::Handler.default.run(Sword.new, @settings)
    end

    def on(*args, &block)
      @options << [*args, lambda(&block)]
    end

    def set(key, value)
      @settings[key] = value
    end
  end

  on '-p', '--port <number>', 'Specify port, default: 1111' do |number|
    set :Port, number
  end

  on '-v', '--version', "Print Sword's version" do
    require 'sword/version'
    puts 'Sword ' << Sword::VERSION
    exit
  end

  on '-d', '--directory <path>', 'Specify root, default: ./' do |path|
    require 'fileutils'
    FileUtils.cd path
  end

  on '-i', '--ip <address>', '0.0.0.0 by default' do |address|
    set :Host, address
  end

  on '-c', '--compile', 'Compile the project' do
    map = Tilt.respond_to?(:lazy_map) ? Tilt.lazy_map : Tilt.mappings
    map.delete('html')

    def Sword.q(*args); end # mock

    def Sword.g(route, &block)
      return if route == '/favicon.ico'
      open(  './' << route, 'w') { |f| f.puts yield }
      puts '  - ' << route[1..-1]
    end

    puts 'Compiled:'

    Sword.instance_eval { extend Sword::Helpers }
    Sword._
    exit
  end
end
