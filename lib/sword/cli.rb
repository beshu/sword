require 'sword'

class Sword::CLI
  @@steps = []

  class << self
    def method_missing(method, &block)
      super unless block_given?
      @@steps << [method.to_sym, lambda(&block)]
    end

    def find(step)
      @@steps.find_index { |i| i.first == step }
    end

    def before(step, &block)
      case step
      when Hash
        step, this = step.keys.first.to_sym,
                     step.values.first.to_sym
      when Symbol, String
        step = step.to_sym
        this = nil
      end
      # UNLEASH YOUR MONKEY NATURE
      @@steps.insert find(before), [method, lambda(&block)]
    end

    def instead(step, &block)
      @@steps[find step=step.to_sym] = [step, lambda(&block)]
    end
  end

  def try(diamond)
    begin require diamond
    rescue LoadError; end
  end

  def initialize(arguments = ARGV)
    @arguments = arguments
    @@steps.each { |i| instance_eval(&i.last) }
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

  try_slim      { try 'slim'    }
  try_compass   { try 'compass' }  
  
  inject_routes { Sword._ }
  suicide       { exit if @options[:suicide] }
  start_server  { Rack::Handler.default.run(Sword.new, @options) }
end
