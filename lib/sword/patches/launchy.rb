Sword::Patch.new 'launchy' do
  module Sword::CLI
    on '-o', '--open', 'Open development page in the browser' do
      Launchy.open "http://127.0.0.1:#{@settings[:Port]}"
    end
  end
end
