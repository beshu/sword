require 'sword'

class Sword::CLI
  @@initializers = []

  def initialize(arguments = ARGV)
    @arguments = arguments
    @@initializers.each { |i| instance_eval(&i) }
  end

  def self.method_missing(_,&block)
    @@initializers << Proc.new(&block)
  end

  parse_options do
    require 'sword/tuner'
    @options = Sword::Tuner.new(@arguments)
  end

  filter_rack_options do
    @rack = @options.select { |o,_| /[A-Z]/ =~ o[0] }
    @options.delete(@rack)
  end

  change_directory do
    if directory = @options.delete(:directory)
      require 'fileutils'
      FileUtils.cd(directory)
    end
  end

  inject_routes { Sword.class_eval { l } }
  start_server  { Rack::Handler.default.run(Sword.new, @rack) }
end
