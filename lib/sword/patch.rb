class Sword::Patch
  def initialize(names, &block)
    Array(names).each do |name|
      if installed? name
        yield
        break
      end
    end
  end

  def installed?(name)
    begin
      require name
    rescue LoadError
    end
  end
end

require 'sword/patches/helpers'
require 'sword/patches/markdown'
require 'sword/patches/compass'
require 'sword/patches/stylus'
