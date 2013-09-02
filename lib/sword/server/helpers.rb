module Sword
  module Server
    module Helpers
      # @todo Google fonts helper
      def font(options) end

      def script(src)
        "<script src='#{src}'></script>"
      end

      def stylesheet(href)
        "<link rel='stylesheet' href='#{href}'/>"
      end

      def jquery(version = '1.8.3')
        script "http://ajax.googleapis.com/ajax/libs/jquery/#{version}/jquery.min.js"
      end

      def bootstrap_css(version = '3.0.0')
        stylesheet "http://yandex.st/bootstrap/#{version}/css/bootstrap.min.css"
      end

      def bootstrap_js(version = '3.0.0')
        script "http://yandex.st/bootstrap/3.0.0/js/bootstrap.min.js"
      end

      def bootstrap(version = '3.0.0')
        bootstrap_js + bootstrap_css
      end

      def fotorama_css(version = '4.1.5')
        stylesheet "http://fotorama.s3.amazonaws.com/#{version}/fotorama.css"
      end

      def fotorama_js(version = '4.1.5')
        script "http://fotorama.s3.amazonaws.com/#{version}/fotorama.js"
      end

      def fotorama(version = '4.1.5')
        fotorama_css(version) + fotorama_js(version)
      end

      def birmanizer(version = '0.0.0')
        script "https://s3-eu-west-1.amazonaws.com/birmanizer/#{version}.js"
      end

      def mootools(version = '1.3.1')
        script "http://yandex.st/mootools/#{version}/mootools.min.js"
      end

      def prototype(version = '1.7.0.0')
        script "http://yandex.st/prototype/#{version}/prototype.min.js"
      end

      def raphael(version = '2.1.0')
        script "http://yandex.st/raphael/#{version}/raphael.min.js"
      end

      def highlight(version = '7.3')
        script "http://yandex.st/highlightjs/#{script}/highlight.min.js"
      end

      def dojo(version = '1.9.1')
        script "http://yandex.st/dojo/#{version}/dojo/dojo.js"
      end
    end
  end
end
