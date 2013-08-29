module Sword
  module Plugins
    class FilterOptions < CLI::Options
      desc 'List script engines you want to use'
      parse :scripts, Array do |engines|
        Environment.filter_scripts = engines
      end

      desc 'List style engines you want to use'
      parse :styles, Array do |engines|
        Environment.filter_styles = engines
      end

      desc 'List template engines you want to use'
      parse :templates, Array do |engines|
        env = engines
      end
    end
  end
end
