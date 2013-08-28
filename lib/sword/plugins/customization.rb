module Sword
  module Plugins
    class Customization < Sword::CLI::Options
      @parser.separator 'Customization options:'

      def parse_favicon
        @parser.on '--favicon <path>', 'Specify favicon' do |path|
          sdebugln "Make #{path} the default favicon"
          Environment.favicon = path
        end
      end
    end
  end
end
