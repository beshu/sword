require 'optparse'

module Sword::Tuner
  DEFAULTS = {:Port => 1111}
  @parsers = []

  class << self
    def new(arguments)
      @options = DEFAULTS
      OptionParser.new do |op|
        @parsers.sort.each { |p| op.on(*p) }
      end.parse(arguments)
      @options
    end

    def on(*args, &block)
      @parsers << [*args, lambda(&block)]
    end

    def set(key, value)
      @options[key] = value
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
    set :directory, path
  end

  on '-i', '--ip <address>', '0.0.0.0 by default' do |address|
    set :Host, address
  end

  on '-c', '--compile', 'Compile the project' do
    (Tilt.respond_to?(:lazy_map) ? Tilt.lazy_map : Tilt.mappings).delete 'html'

    def Sword.q(*args); end # mock

    def Sword.g(route, &block)
      return if route == '/favicon.ico'
      open(  './' << route, 'w') { |f| f.puts yield }
      puts '  - ' << route[1..-1]
    end

    Sword::CLI.instead_of(:start_server) {}
    puts 'Compiled:'
  end
end
