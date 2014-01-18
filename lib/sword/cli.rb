require 'sword'
require 'sword/helpers'

module Sword::CLI
  @tasks = []

  class << self
    def new(arguments = ARGV)
      @arguments = arguments
      @tasks.each { |tt| instance_eval(&tt.last) }
    end

    def task(name, &block)
      super unless block_given?
      @tasks << [name.to_sym, lambda(&block)]
    end

    def try(diamond)
      begin require diamond
      rescue LoadError; end
    end

    def index_of(task)
      @tasks.find_index { |tt| tt.first == task }
    end

    def before(task, &block)
      case task
      when Hash
        task, this = task.keys.first.to_sym,
                     task.values.first.to_sym
      when Symbol, String
        task = task.to_sym
        this = nil
      end

      # UNLEASH YOUR MONKEY NATURE
      @tasks.insert index_of(task), [this, lambda(&block)]
    end

    def instead(task, &block)
      @tasks[index_of task=task.to_sym] = [task, lambda(&block)]
    end

    alias instead_of instead
  end

  task :parse_options do
    require 'sword/tuner'
    @options = Sword::Tuner.new(@arguments)
  end

  task :change_directory do
    if directory = @options.delete(:directory)
      require 'fileutils'
      FileUtils.cd(directory)
    end
  end

  task :load_compass do
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
  end

  task(:inject_helpers) { Sword.instance_eval { include Sword::Helpers } }
  task(:inject_routes)  { Sword._ }
  task(:start_server)   { Rack::Handler.default.run(Sword.new, @options) }
end
