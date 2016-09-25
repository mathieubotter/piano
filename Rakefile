require 'rake'

task :default do
  ENV['RACK_ENV'] = 'test'
  Rake::Task['test'].invoke
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc "Start the server"
task :start do
  Kernel.exec "bundle exec shotgun"
end
