require 'sword'

class Sword::CLI
  @@initializers = []
  private # black box

  class << self
    def method_missing(method, &block)
      super unless block_given?
      @@initializers << [method, Proc.new(&block)]
    end

    def before(method, &block)
      index = @@initializers.find_index { |i| i.first == method }
      @@initializers.insert index, [Proc.new(&block)]
    end
  end

  def initialize(arguments = ARGV)
    @arguments = arguments
    @@initializers.each { |i| instance_eval(&i.last) }
  end

  parse_options do
    require 'sword/tuner'
    @options = Sword::Tuner.new(@arguments)
  end

  change_directory do
    if directory = @options.delete(:directory)
      require 'fileutils'
      FileUtils.cd(directory)
    end
  end

  inject_routes { Sword._ }
  start_server  { Rack::Handler.default.run(Sword.new, @options) }
end
