module Sword
  module Server
    module Templates
      def find_engine(template, options)
        template.each do |language|
          language.each do |engine, extensions|
            extensions.each do |extension|
              return send(engine, name.to_sym, options) if File.exists? "#{name}.#{extension}"
            end
          end
        end
        false
      end

      def inject_templates
        Environment.templates.each do |name, table|
          instance_variable_set(name, table)
        end
      end
    end
  end
end