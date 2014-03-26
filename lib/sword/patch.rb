# This class describes patches that apply automatically
# if they succeed in loading the gem they're patching.
class Sword::Patch
  attr_reader :names

  # @param names [String, Array] list of gems
  def initialize(names, &block)
    @names = Array(names)
    @enabled = false
    patch!(&block)
  end

  # @return [Bool]
  def enabled?
    @enabled
  end

  private

  # Runs a patch code from &block if any gem from
  # @names is installed.
  #
  # @param [&block] patch code
  def patch!(&block)
    @names.each do |name|
      if installed? name
        yield
        return @enabled = true
      end
    end
  end

  # Checks if gem is installed. If it is, loads the gem
  # and returns true. False otherwise.
  #
  # @param name [String] like Kernel#require argument
  # @return [Bool] installed or not
  # @example Print Compass version if the gem is present
  #   if installed? 'compass'
  #     puts "Compass version is #{Compass::VERSION}!"
  #   end
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
