#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'exalted_math'

include Exalted
describe "Exalted::MathParser" do
  before do
    @parser = Exalted::MathsParser.new
  end

  [
    ['4', Ast.num(4)],
    ['-1', Ast.num(-1)],
    ['3 * 4', Ast.mul(Ast.num(3), Ast.num(4) )],
    ['3 - 4', Ast.sub(Ast.num(3), Ast.num(4) )],
    ['3 + 4', Ast.add(Ast.num(3), Ast.num(4) )],
    ['6 / 3', Ast.div(Ast.num(6), Ast.num(3) )],
    ['Essence * 4', Ast.mul(Ast.stat('essence'), Ast.num(4) )],
    ['(Essence * 4) + Willpower', Ast.add(Ast.mul(Ast.stat('essence'), Ast.num(4) ), Ast.stat('willpower'))]
  ].each do |string, ast|
    it "parses '#{string}'" do
      success, result = @parser.ast(string)
      success.should.be.true
      result.should == ast
    end
  end
end

