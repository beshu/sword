require 'optparse'

module Sword::Tuner
  @parsers = []
  DEFAULTS  = {:Port => 1111}
  private # we, crypto-anarchists are
          # keen on this privacy thing

  class << self
    def new(arguments)
      @options = DEFAULTS
      OptionParser.new do |op|
        @parsers.sort.each { |p| op.on(*p) }
      end.parse(arguments)
      @options
    end

    def on(*args, &block)
      @parsers << [*args, Proc.new(&block)]
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
    set :Host, ip
  end
end
