require 'singleton'

module Sword
  module Execute
    class Filter
      include Singleton

      def self.filter
        Environment.templates.keys.each { |k| instance.send k }
      end

      def method_missing(list, *args)
        list = list.to_s
        method = "filter_#{list}".to_sym
        env = Environment.send method

        return unless env and Environment.templates[list]
        Environment.templates[list].delete_if { |k,_| not env.include? k }
      end
    end
  end
end
