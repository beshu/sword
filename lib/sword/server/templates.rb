module Sword
  module Server
    module Templates
      # Generate instance variables containing parsed versions of YAML engine lists.
      # Variable names are identical to file names.
      #
      # @note
      #   Format is as follows:
      #   string is both engine method and the only extension,
      #   hash is the key is an engine method and the value is an array of extensions
      def inject_template_variables_first
        Environment.templates.each do |engine, rules|
          instance_variable_set('@' << engine, rules)
        end
      end

      def find_engine(template, name, options)
        template.each do |engine, extensions|
          extensions.each do |extension|
            return send(engine, name.to_sym, options) \
              if File.exists? "#{Environment.directory}/#{name}.#{extension}"
          end
        end
        false
      end
    end
  end
end