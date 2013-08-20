require 'rubygems'

module Sword
  module Installer
    GEMS = %w[sass compass slim haml]

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
      begin
        @sudo ? sudo_install_gem(name) : just_install_gem(name)
      rescue
        unless @sudo
          @sudo = true
          print 'Trying sudo... '
          retry
        end
        raise
      end
    end

    def self.sudo_install_gem(name)
      system "sudo gem install #{name}"
    end

    def self.just_install_gem(name)
      system "gem install #{name}"
    end
  end
end