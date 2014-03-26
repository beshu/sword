# coding: utf-8
require 'optparse'
require 'sword'
require 'sword/patch'

module Sword::CLI
  DEFAULTS = {:Port => 1111}
  @options = []

  class << self
    def new(arguments = ARGV)
      @settings = DEFAULTS
      parser.parse!(arguments)
      run! unless suicide?
    end

    def suicide?
      @suicide ||= false
    end

    # Prevents Sword from continuing running.
    def suicide!
      @suicide = true
    end

    # @return [OptionParser]
    def parser
      @parser ||= OptionParser.new do |op|
        @list = op
        @options.sort.each { |p| op.on(*p) }
      end
    end

    # Find the most appropriate Rack handler for your platform
    # and run Sword on it.
    def run!
      Sword._
      Rack::Handler.default.run(Sword.new, @settings)
    end

    # Delegator to OptionParser#on method. Saves arguments
    # to pass them later into new OptionParser instance.
    def on(*args, &block)
      @options.push args << lambda(&block)
    end

    def set(key, value)
      @settings[key] = value
    end
  end

  on '-p', '--port <number>', ':1111 by default' do |number|
    set :Port, number
  end

  on '-v', '--version', "Print Sword's version" do
    require 'sword/version'
    puts 'Sword ' << Sword::VERSION
    exit
  end

  on '-d', '--directory <path>', 'Current directory by default' do |path|
    require 'fileutils'
    FileUtils.cd path
  end

  on '-i', '--ip <address>', '0.0.0.0 by default' do |address|
    set :Host, address
  end

  on '--interactive', 'Enable interactive flag input' do
    require 'shellwords'
    print @list, "\n> "
    suicide!

    begin
      new Shellwords.split($stdin.gets)
    rescue Interrupt
      print "\n"
    end
  end

  on '-c', '--compile', 'Compile the project' do
    map = Tilt.respond_to?(:lazy_map) ? Tilt.lazy_map : Tilt.mappings
    map.delete('html')
    suicide!

    def Sword.q(*args) end # mock

    def Sword.g(route, &block)
      return if route == '/favicon.ico'
      open('./' << route, 'w') { |f| f.puts yield }
      puts '✓ ' << route[1..-1]
    end

    Sword.instance_eval { extend Sword::Helpers }
    Sword._
  end
end
