require 'rubygems'

module Sword
  module Installer
    GEMS = %w[compass slim haml]
    SOURCE = %w[redcarpet coffee-script stylus thin]

    SudoError = Class.new(LoadError)

    def self.install(sudo = false)
      @sudo = sudo
      install_from GEMS
      install_therubyracer unless WINDOWS
      install_from SOURCE  unless defined? JRUBY_VERSION
      print "\n"
    end

    def self.install_from(list)
      list.each do |name|
        begin
          require name
        rescue LoadError
          install_gem(name)
        end
      end
    end

    def self.install_therubyracer
      require 'less'
    rescue LoadError
      install_gem('therubyracer')
      install_gem('less')
    end

    def self.install_gem(name)
      print "#{name}... "
      query = system @sudo ? "sudo gem install #{name}" : "gem install #{name}"
      raise SudoError unless query
    rescue SudoError
      raise if @sudo
      print 'Trying sudo... '
      @sudo = true
      retry
    end
  end
end
