# This class describes patches that apply automatically
# if they succeed in loading the gem they're patching.
class Sword::Patch
  # @param names [String, Array] list of gems
  def initialize(names = nil, &block)
    @names = Array(names)
    names ? patch!(&block) : yield
  end

  def self.load
    Dir[File.dirname(__FILE__) << '/patches/*.rb'].each { |p| require p }
  end

  private

  # Runs a patch code from &block if any gem from
  # @names is installed.
  def patch!
    @names.each do |name|
      if installed?(name)
        yield if block_given?
        break
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
      true
    rescue LoadError
    end
  end
end
