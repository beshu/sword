module Sword
  module Plugins
    class Deploy < Sword::CLI::Options
      parse :cache, 'Turn on caching for some engines'
      parse :console, "Don't open browser"
      parse :daemonize, 'Daemonize Sword' unless System::OLD_RUBY
      parse :here, "Don't change directory"

      parse :server, 'Specify server' do |name|
        Environment.server = name
      end

      desc 'Apply production settings'
      parse :production do
        Environment.configure do |e|
          e.console = true
          e.daemonize = true unless System::OLD_RUBY
          e.compress = true
          e.cache = true
        end
      end
    end
  end
end
