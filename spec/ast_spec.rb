#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'exalted_math/ast'

describe "Exalted::Ast" do
  before do
    @three    = Exalted::Ast.new(['num', 3 ])
    @seven    = Exalted::Ast.new(['num', 7 ])
    @foo      = Exalted::Ast.new(['stat', 'foo'])
    @bar      = Exalted::Ast.new(['stat', 'bar'])
    @invalid  = Exalted::Ast.new(['stat', 'invalid'])
    @add      = Exalted::Ast.new(['add', @three, @seven])
    @sub      = Exalted::Ast.new(['sub', @three, @seven])
    @mul      = Exalted::Ast.new(['mul', @three, @seven])
    @div      = Exalted::Ast.new(['div', @seven, @three])
    @add_foo  = Exalted::Ast.new(['add', @three, @foo])
    @sub_foo  = Exalted::Ast.new(['sub', @three, @foo])
    @mul_foo  = Exalted::Ast.new(['mul', @three, @foo])
    @div_foo  = Exalted::Ast.new(['div', @three, @foo])
    @nested   = Exalted::Ast.new(['mul', @add, @sub_foo])
    @context  = { 'foo' => 3, 'bar' => 4 }
  end

  it "a number is constant" do
    @three.should.be.constant
  end

  it "a stat is not constant" do
    @foo.should.not.be.constant
  end

  it "an add of two constants is constant" do
    @add.should.be.constant
  end
  it "an sub of two constants is constant" do
    @sub.should.be.constant
  end
  it "an mul of two constants is constant" do
    @mul.should.be.constant
  end
  it "an div of two constants is constant" do
    @div.should.be.constant
  end

  it "an add of constant and not constant is not constant" do
    @add_foo.should.not.be.constant
  end
  it "an sub of constant and not constant is not constant" do
    @sub_foo.should.not.be.constant
  end
  it "an mul of constant and not constant is not constant" do
    @mul_foo.should.not.be.constant
  end
  it "an div of constant and not constant is not constant" do
    @div_foo.should.not.be.constant
  end

  it "A number is valid" do
    Exalted::Ast.valid?(@three, @context.keys).should.be.true
  end

  it "A stat is valid if it is in the array of valid keys" do
    Exalted::Ast.valid?(@foo, @context.keys).should.be.true
  end

  it "A stat is not valid if it is not in the array of valid keys" do
    Exalted::Ast.valid?(@invalid, @context.keys).should.not.be.true
  end

  it "An add is valid if both its keys are valid" do
    Exalted::Ast.valid?(@add, @context.keys).should.be.true
  end
  it "An sub is valid if both its keys are valid" do
    Exalted::Ast.valid?(@sub, @context.keys).should.be.true
  end
  it "An mul is valid if both its keys are valid" do
    Exalted::Ast.valid?(@mul, @context.keys).should.be.true
  end
  it "An div is valid if both its keys are valid" do
    Exalted::Ast.valid?(@div, @context.keys).should.be.true
  end
  it "An add is invalid if one key is invalid" do
    @add = Exalted::Ast.new(['add', @three, @invalid])
    Exalted::Ast.valid?(@add, @context.keys).should.not.be.true
  end
  it "An sub is invalid if one key is invalid" do
    @sub = Exalted::Ast.new(['sub', @three, @invalid])
    Exalted::Ast.valid?(@sub, @context.keys).should.not.be.true
  end
  it "An mul is invalid if one key is invalid" do
    @mul = Exalted::Ast.new(['mul', @three, @invalid])
    Exalted::Ast.valid?(@mul, @context.keys).should.not.be.true
  end
  it "An div is invalid if one key is invalid" do
    @div = Exalted::Ast.new(['div', @three, @invalid])
    Exalted::Ast.valid?(@div, @context.keys).should.not.be.true
  end

  it "the value of a number is the number" do
    Exalted::Ast.value(@three, @context).should == 3
    Exalted::Ast.value(@seven, @context).should == 7
  end

  it "the value of a stat is looked up in the context" do
    Exalted::Ast.value(@foo, @context).should == @context['foo']
    Exalted::Ast.value(@bar, @context).should == @context['bar']
  end

  it "the value of an add is the sum of the two children" do
     Exalted::Ast.value(@add, @context).should == 10
  end

  it "the value of an sub is first child minus the second" do
    Exalted::Ast.value(@sub, @context).should == -4
  end

  it "the value of an mul is the two children multiplied together" do
    Exalted::Ast.value(@mul, @context).should == 21
  end

  it "the value of a div is the first child divided by the second" do
    Exalted::Ast.value(@div, @context).should == 2
  end

  it "it walks the whole tree to compute a value" do
     Exalted::Ast.value(@nested, @context).should == 0
  end

  it "has sane equality behaviour" do
    @three.should == Exalted::Ast.new(['num', 3])
  end

  it "can simplify a constant add" do
    Exalted::Ast.simplify(@add).should == Exalted::Ast.new(['num', 10])
  end

  it "A number is simple" do
    Exalted::Ast.simplify(@three).should == Exalted::Ast.new(['num', 3])
  end

  it "A stat is simple" do
    Exalted::Ast.simplify(@foo).should == Exalted::Ast.new(['stat', 'foo'])
  end

  it "A non-constant add isn't simplified" do
    Exalted::Ast.simplify(@add_foo).should == Exalted::Ast.new(['add', @three, @foo])
  end
  it "A constant branches are simplified" do
    Exalted::Ast.simplify(@nested).should == Exalted::Ast.new(['mul', Exalted::Ast.new(['num', 10]), @sub_foo])
  end
end

