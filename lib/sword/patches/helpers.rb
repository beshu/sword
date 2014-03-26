Sword::Patch.new 'sword/helpers' do 
  Sword.instance_eval { include Sword::Helpers }
end
