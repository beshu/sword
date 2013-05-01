require 'rake/testtask'
task :default => [:test]

Rake::TestTask.new do |test|
  test.libs << 'test'
  test.test_files = Dir['test/*.rb']
  test.verbose = true
end

task :make do
  exec './make.sh'
end

task :update do
  exec 'gem install sword && gem cleanup sword'
end
