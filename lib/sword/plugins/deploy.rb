module Sword
  module Execute
    module Options
      def parse_cache
        @parser.on '--cache', 'Turn on caching for some engines' do
          Environment.cache = true
        end
      end

      def parse_console
        @parser.on '--console', "Don't open browser" do
          Environment.console = true
        end
      end

      def parse_server
        @parser.on '--server <name>', 'Specify server' do |name|
          Environment.server = name
        end
      end

    end
  end
end
