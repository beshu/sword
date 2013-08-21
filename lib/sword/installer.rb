require 'rubygems'

module Sword
  module Installer
    GEMS = %w[compass slim haml]
    class SudoError < LoadError; end

    def self.install(sudo = false)
      @sudo = sudo
      GEMS.each do |name|
        begin
          require name
        rescue LoadError
          install_gem(name)
        end
      end
      print "\n"
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