require 'sword'
require 'sword/helpers'

class Sword::CLI
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
      @@steps.insert find(step), [this, lambda(&block)]
    end

    def instead(step, &block)
      @@steps[find step=step.to_sym] = [step, lambda(&block)]
    end

    alias instead_of instead
  end

  def initialize(arguments = ARGV)
    @arguments = arguments
    @@steps.each { |i| instance_eval(&i.last) }
  end

  def try(diamond)
    begin require diamond
    rescue LoadError; end
  end

  @@steps = [] # ↓

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

  load_compass {
    if try 'compass'
      [Tilt::ScssTemplate, Tilt::SassTemplate].each do |t|
        t.class_eval {
          def sass_options
            Compass.sass_engine_options.merge(options).
            merge :filename => eval_file, :line => line
          end
        }
      end

      Compass.configuration { |c|
        c.project_path = '.'
        c.sass_dir     = c.project_path
      }
    end
  }


  inject_helpers { Sword.instance_eval { include Sword::Helpers } }
  inject_routes  { Sword._ }
  start_server   { Rack::Handler.default.run(Sword.new, @options) }
end
