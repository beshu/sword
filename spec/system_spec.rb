require 'support'
require 'sword/system'
require 'securerandom'

ORIGINAL_VERBOSITY = $VERBOSE

def reload
  $VERBOSE = nil
  load 'sword/system.rb'
  $VERBOSE = ORIGINAL_VERBOSITY
end

describe Sword::System do
  let(:system) { described_class }

  it 'should have OCRA constant' do
    should have_constant :OCRA
  end

  it 'should have WINDOWS constant' do
    should have_constant :WINDOWS
  end

  it 'should have OSX constant' do
    should have_constant :OSX
  end

  it 'should have OLD_RUBY constant' do
    should have_constant :OLD_RUBY
  end

  it 'should have OLD_RUBY true if running on Ruby 1.8.7' do
    stub_const('::RUBY_VERSION', '1.8.7')
    reload
    system::OLD_RUBY.should be_true
  end

  it 'should have OLD_RUBY false if running on Ruby 1.9.3' do
    stub_const('::RUBY_VERSION', '1.9.3')
    reload
    system::OLD_RUBY.should be_false
  end

  it 'should have OLD_RUBY false if running on Ruby 2.0.0' do
    stub_const('::RUBY_VERSION', '2.0.0')
    reload
    system::OLD_RUBY.should be_false
  end

  it 'should have OCRA true if I have "ocra" arguments inside my ARGV' do
    stub_const('::ARGV', %w[empty ocra random -h !!])
    reload
    system::OCRA.should be_true
  end

  it 'should have OSX true if I have "darwin" substring included in my RUBY_PLATFORM' do
    stub_const('::RUBY_PLATFORM', 'x86_64-darwin12.4.1')
    reload
    system::OSX.should be_true
  end
end
