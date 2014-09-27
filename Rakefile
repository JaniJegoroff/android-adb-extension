require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.test_files = FileList['spec/**/spec_*.rb']
  t.verbose = true
end

task :default => :test
