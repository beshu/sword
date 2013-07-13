require 'rbconfig'

module Sword
  module Windows
    # Check if we’re running Windows there:
    WINDOWS = RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
  end
end
