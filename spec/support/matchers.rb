require 'pp'

ORIGINAL_VERBOSITY = $VERBOSE

def reload_system
  $VERBOSE = nil
  load 'sword/system.rb'
  $VERBOSE = ORIGINAL_VERBOSITY
end

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end

RSpec::Matchers.define :have_method do |method|
  match do |owner|
    owner.method_defined?(method)
  end
end

RSpec::Matchers.define :have_option do |option|
  def option_list(parser)
    instance = parser.instance_eval { @parser }
    instance.instance_eval { @stack.map(&:list).delete_if(&:empty?) }.first
  end

  match do |parser|
    if option.instance_of? Array and option.length == 2
      shorthand = option.first
      option = option.last
    else
      shorthand = false
    end

    method = "parse_#{option}".to_sym
    method_defined_correctly = parser.respond_to? method

    list = option_list(parser)
    long = '--' << option.to_s.gsub('_', '-')

    if shorthand
      short = '-' << shorthand.to_s
      short_present = list.map(&:short).flatten.include? short
    end

    long_present = list.map(&:long).flatten.include? long
    short_present ||= true

    method_defined_correctly && long_present && short_present
  end
end
