module Sword
  module Execute
    class Manager
      def initialize(options, &block)
        @options = options
        return build if @options.delete(:build)
        return generate if @options.delete(:generate)
        return run
      end

      protected

      def load
        load_require
        Dir[''].each { |y| require_all tilt(y) }
      end

      def load_require
        require 'sword/boot/require'
        include Require
      end

      def tilt(file)
        YAML.load_file(file).map { |l| l.map { |e| String === e ? {e => [e]} : e } }
      end

      private

      def build
        require 'sword/builder'
        Builder.new(@options)
      end

      def generate
        require 'sword/generator'
        Generator.new(@options)
      end

      def run
        require 'sword/core/application'
        Core::Application.run!(@options)
      end
    end
  end
end
