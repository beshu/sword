require 'support'
require 'sword/environment'

describe Sword::Environment do
  it { should be_instance_of OpenStruct }
  
  it { should respond_to :port }
  it 'should be preset to 1111' do
    Sword::E.port.should == 1111
  end

  it 'should have E synonym' do
    Sword.should have_constant :E
    should === Sword::E
  end

  it { should respond_to :directory }
  it 'should have . as a default directory' do
    Sword::E.directory.should == '.'
  end

  it { should respond_to :templates }
  it 'should have templates as Hash instance' do
    Sword::E.templates.should be_instance_of Hash
  end

  it { should respond_to :layouts }
  it 'should have layouts as Array instance' do
    Sword::E.layouts.should be_instance_of Array
  end
end
