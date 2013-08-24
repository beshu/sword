RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end

RSpec::Matchers.define :have_option do |option|
  method = "parse_#{option}".to_sym
  match do |parser|
    parser.method_defined?(method)
  end
end
