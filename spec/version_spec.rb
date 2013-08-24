require File.expand_path('../helper', __FILE__)
require 'sword/version'

describe Sword::VERSION do
  it 'should exist' do
    Sword.should have_constant :VERSION
  end

  it 'should be three numbers divided by commas' do
    version = Sword::VERSION.split('.', 3).map { |n| instance_eval n }
    Sword::VERSION.should == version.map(&:to_s).join('.')
  end
end
