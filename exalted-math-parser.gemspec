# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{exalted-math-parser}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Stott"]
  s.date = %q{2010-06-06}
  s.description = %q{Parsing and evaluation of simple maths expressions for Exalted

This intended to aid in evaluating simple calculations which appear on character sheets, especially for Exalted.}
  s.email = %q{jonathan.stott@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/exalted_math.rb",
     "lib/exalted_math/ast.rb",
     "lib/exalted_math/math.rb",
     "lib/exalted_math/math.treetop",
     "spec/ast_spec.rb",
     "spec/parser_spec.rb",
     "spec/spec_helper.rb",
     "treetop_test.rb"
  ]
  s.homepage = %q{http://github.com/namelessjon/exalted-math-parser}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Parsing and evaluation of simple maths expressions for Exalted}
  s.test_files = [
    "spec/ast_spec.rb",
     "spec/spec_helper.rb",
     "spec/parser_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<treetop>, ["~> 1.4"])
      s.add_development_dependency(%q<bacon>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
    else
      s.add_dependency(%q<treetop>, ["~> 1.4"])
      s.add_dependency(%q<bacon>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
    end
  else
    s.add_dependency(%q<treetop>, ["~> 1.4"])
    s.add_dependency(%q<bacon>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
  end
end

