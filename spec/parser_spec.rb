#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'exalted_math'

describe "Exalted::MathParser" do
  before do
    @parser = Exalted::MathsParser.new
  end

  [
    ['4', Exalted::Ast.new('num', 4)],
    ['-1', Exalted::Ast.new('num', -1)],
    ['3 * 4', Exalted::Ast.new('mul', Exalted::Ast.new('num', 3), Exalted::Ast.new('num', 4) )],
    ['3 - 4', Exalted::Ast.new('sub', Exalted::Ast.new('num', 3), Exalted::Ast.new('num', 4) )],
    ['3 + 4', Exalted::Ast.new('add', Exalted::Ast.new('num', 3), Exalted::Ast.new('num', 4) )],
    ['6 / 3', Exalted::Ast.new('div', Exalted::Ast.new('num', 6), Exalted::Ast.new('num', 3) )],
    ['Essence * 4', Exalted::Ast.new('mul', Exalted::Ast.new('stat', 'essence'), Exalted::Ast.new('num', 4) )],
    ['(Essence * 4) + Willpower', Exalted::Ast.new('add', Exalted::Ast.new('mul', Exalted::Ast.new('stat', 'essence'), Exalted::Ast.new('num', 4) ), Exalted::Ast.new('stat', 'willpower'))]
  ].each do |string, ast|
    it "parses '#{string}'" do
      success, result = @parser.ast(string)
      success.should.be.true
      result.should == ast
    end
  end
end

