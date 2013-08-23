require 'rbconfig'

module Sword
  module System
    WINDOWS = RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
    OCRA = ARGV.delete('ocra')
    OSX = RUBY_PLATFORM.include? 'darwin'
    NEW = RUBY_VERSION >= '1.9.1'
  end
end
