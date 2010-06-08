#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'exalted_math'

include Exalted

class ParserFailure < Bacon::Error
  def initialize(failure)
    super :failure, failure
  end
end
describe "Exalted::MathParser" do
  before do
    @parser = Exalted::MathsParser.new
  end

  [
    [' 4 ', Ast.num(4)],
    [' -1 ', Ast.num(-1)],
    [' 3 * 4 ', Ast.mul(Ast.num(3), Ast.num(4) )],
    [' 3 - 4 ', Ast.sub(Ast.num(3), Ast.num(4) )],
    [' 3 + 4 ', Ast.add(Ast.num(3), Ast.num(4) )],
    [' 6 / 3 ', Ast.div(Ast.num(6), Ast.num(3) )],
    [' spec:"Beating stuff" ', Ast.spec("Beating stuff")],
    ['Essence * 4', Ast.mul(Ast.stat('essence'), Ast.num(4) )],
    ['(Essence * 4) + Willpower', Ast.add(Ast.mul(Ast.stat('essence'), Ast.num(4) ), Ast.stat('willpower'))],
    ['highest[2](compassion,conviction,temperance,valor)', Ast.max(2, [Ast.stat('compassion'),Ast.stat('conviction'),Ast.stat('temperance'),Ast.stat('valor') ])],
    ['min(compassion,conviction,temperance,valor)', Ast.min(1, [Ast.stat('compassion'),Ast.stat('conviction'),Ast.stat('temperance'),Ast.stat('valor') ])]
  ].each do |string, ast|
    it "parses '#{string}'" do
      success, result = @parser.ast(string)
      raise ParserFailure, result unless success
      success.should.be.true
      result.should == ast
    end
  end

  it "Doesn't care about spaces" do
    success, result = @parser.ast(' ( Essence * 4 ) + Willpower + highest[2]( compassion , conviction ) ')
    raise ParserFailure, result unless success
    success.should.be.true
  end
end

