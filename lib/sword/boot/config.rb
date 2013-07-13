require 'yaml'

module Sword
  module Boot
    module Config
      def parse_tilt_config(file)
        YAML.load_file(file).map { |l| l.map { |e| String === e ? {e => [e]} : e } }
      end

    end
  end
end
