# Rakefile for phedre
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib' << 'spec' << 'app'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

task :default => :spec

