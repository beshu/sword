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

RSpec::Matchers.define :have_option do |option|
  method = "parse_#{option}".to_sym
  match { |parser| parser.respond_to? method }

  match do |parser|
    option = option.to_s.gsub('_', '-').to_sym
    instance = parser.instance_eval { @parser }
    options = instance.instance_eval { @stack.map(&:list).delete_if(&:empty?) }
    long = "--#{option}"
    options.first.map(&:long).flatten.include? long
  end
end
