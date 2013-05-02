describe 'running and loading' do
  it 'prints the version' do
    assert_equal `bin/sword -v`, "Sword #{Sword::VERSION}\n"
  end
  it 'prints help information' do
    assert `sword -h`['Usage: sword [options]']
  end
  it 'starts' do
  end
end
