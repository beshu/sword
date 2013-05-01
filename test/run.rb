require 'helper'

class SwordRunTest < Test::Unit::TestCase
  it 'starts' do
    assert_equal `bin/sword`
  end
end
