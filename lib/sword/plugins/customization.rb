module Sword
  module Plugins
    class Customization < Sword::CLI::Options
      separator "Customization options:\n"

      desc 'Specify favicon'
      parse :favicon do |path|
        Environment.favicon = path
      end

      desc 'Specify error page'
      parse :error do |path|
        Environment.error = path
      end
    end
  end
end
