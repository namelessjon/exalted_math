#!/usr/bin/ruby
require 'spec_helper'
require 'exalted_math'

include ExaltedMath

describe "Exalted::MathParser" do
  before do
    @parser = ExaltedMath::MathsParser.new
  end

  [
    [' 4 ', Node::Number.new(4)],
    [' -1 ', Node::Number.new(-1)],
    [' 3 * 4 ', Node::Multiply.new(Node::Number.new(3), Node::Number.new(4) )],
    [' 3 - 4 ', Node::Subtract.new(Node::Number.new(3), Node::Number.new(4) )],
    [' 3 + 4 ', Node::Add.new(Node::Number.new(3), Node::Number.new(4) )],
    [' 6 / 3 ', Node::Divide.new(Node::Number.new(6), Node::Number.new(3) )],
    [' spec:"Beating stuff" ', Node::Spec.new("Beating stuff")],
    ['Essence * 4', Node::Multiply.new(Node::Stat.new('essence'), Node::Number.new(4) )],
    ['(Essence * 4) + Willpower', Node::Add.new(Node::Multiply.new(Node::Stat.new('essence'), Node::Number.new(4) ), Node::Stat.new('willpower'))],
    ['highest[2](compassion,conviction,temperance,valor)', Node::Maximum.new([Node::Stat.new('compassion'),Node::Stat.new('conviction'),Node::Stat.new('temperance'),Node::Stat.new('valor') ], 2)],
    ['min(compassion,conviction,temperance,valor)', Node::Minimum.new([Node::Stat.new('compassion'),Node::Stat.new('conviction'),Node::Stat.new('temperance'),Node::Stat.new('valor') ], 1)]
  ].each do |string, ast|
    it "parses '#{string}'" do
      result = @parser.ast(string)
      result.should == ast
    end
  end

  it "Doesn't care about spaces" do
    proc { @parser.ast(' ( Essence    * 4 )   +    Willpower + highest[2]( compassion , conviction ) ') }.should.not.raise(ParseFailedError)
  end
end

