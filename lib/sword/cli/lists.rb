require 'yaml'

module Sword
  module Execute
    module Lists
      def self.load
        load_templates
        load_gems
        load_layouts
      end

      def self.parse(file)
        YAML.load_file(file)
      end

      def self.load_templates
        Environment.template_lists.each do |list|
          load_template_list(list)
        end
      end

      def self.parse_template_list(file)
        parse(file).map do |element|
          String === element ? {element => [element]} : element
        end.inject(&:merge)
      end

      def self.load_template_list(file)
        Environment.templates[File.basename(file, '.yml')] = parse_template_list(file)
      end

      def self.load_gems
        lists  = Environment.gem_lists.dup
        lists << Environment.local_gems if File.exists?(Environment.local_gems)
        lists.each { |list| load_gem_list(list) }
      end

      def self.load_gem_list(file)
        list = parse(file)
        return false unless list
        Environment.gems += list
      end

      def self.load_layouts
        Environment.layout_lists.each do |list|
          Environment.layouts += parse_template_list(list).values.flatten
        end
      end
    end
  end
end
