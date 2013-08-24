require 'rbconfig'

module Sword
  module System
    OLD_RUBY = RUBY_VERSION <= '1.8.7'
    WINDOWS = RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    OCRA = ARGV.delete('ocra')
    OSX = RUBY_PLATFORM.include? 'darwin'
  end
end
