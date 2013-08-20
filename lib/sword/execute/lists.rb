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
        YAML.load_file(file).map do |element|
          Environment.templates << element.map { |e| String === e ? {e => [e]} : e }
        end
      end

      def self.load_gems
        lists =  Environment.gem_lists.dup
        lists << Environment.local_gem_list
        lists.each do |list|
          load_gem_list(list)
        end
      end

      def self.load_gem_list
        YAML.load_file(file).map do |element|
          # TODO: finish writing this method
          Environment.gems << element
        end
      end
    end
  end
end