# Rakefile for phedre
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib' << 'spec' << 'app'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = false
end

task :default => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "exalted-math-parser"
    gem.summary = "Parsing and evaluation of simple maths expressions for Exalted"
    gem.description = "Parsing and evaluation of simple maths expressions for Exalted\n\nThis intended to aid in evaluating simple calculations which appear on character sheets, especially for Exalted."
    gem.email = "jonathan.stott@gmail.com"
    gem.homepage = "http://github.com/namelessjon/exalted-math-parser"
    gem.authors = ["Jonathan Stott"]
    gem.add_dependency "treetop", "~> 1.4"
    gem.add_development_dependency "bacon"
    gem.add_development_dependency "yard"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

