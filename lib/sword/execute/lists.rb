require 'yaml'

module Sword
  module Execute
    module Lists
      def self.load
        load_templates
        load_gems
      end

      def self.load_templates
        Environment.template_lists.each do |list|
          load_template_list(list)
        end
      end

      def self.load_template_list(file)
        list = YAML.load_file(file).map do |element|
          String === element ? {element => [element]} : element
        end

        Environment.templates += list
      end

      def self.load_gems
        lists  = Environment.gem_lists.dup
        lists << Environment.local_gems
        lists.each do |list|
          load_gem_list(list)
        end
      end

      def self.load_gem_list(file)
        list = YAML.load_file(file)
        return false unless list
        Environment.gems += list
      end
    end
  end
end