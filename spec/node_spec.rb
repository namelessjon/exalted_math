#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'spec_helper'
require 'exalted_math/node'

include ExaltedMath

class Context
  attr_reader :foo
  def initialize(foo)
    @foo = foo
  end
end

describe "ExaltedMath::Node" do
  before do
    @three    = Node::Number.new(3)
    @seven    = Node::Number.new(7)
    @foo      = Node::Stat.new('foo')
    @bar      = Node::Spec.new('bar')
    @invalid  = Node::Stat.new('invalid')
    @add      = Node::Add.new( @three, @seven)
    @sub      = Node::Subtract.new(@three, @seven)
    @mul      = Node::Multiply.new(@three, @seven)
    @div      = Node::Divide.new(@seven, @three)
    @add_foo  = Node::Add.new(@three, @foo)
    @sub_foo  = Node::Subtract.new(@three, @foo)
    @mul_foo  = Node::Multiply.new(@three, @foo)
    @div_foo  = Node::Divide.new(@three, @foo)
    @nested   = Node::Multiply.new(@add, @sub_foo)
    @min      = Node::Minimum.new([@three, @seven], 1)
    @max      = Node::Maximum.new([@three, @seven], 1 )
    @context  = { 'foo' => 3, 'bar' => 4 }
    @class_context  = Context.new(3)
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
  it "a min of constants is constant" do
    @min.should.be.constant
  end
  it "a max of constants is constant" do
    @max.should.be.constant
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
    @three.valid?(@context.keys).should.be.true
  end

  it "A stat is valid if it is in the array of valid keys" do
    @foo.valid?(@context.keys).should.be.true
  end

  it "A stat is not valid if it is not in the array of valid keys" do
    @invalid.valid?(@context.keys).should.not.be.true
  end

  it "An add is valid if both its keys are valid" do
    @add.valid?(@context.keys).should.be.true
  end
  it "An sub is valid if both its keys are valid" do
    @sub.valid?(@context.keys).should.be.true
  end
  it "An mul is valid if both its keys are valid" do
    @mul.valid?(@context.keys).should.be.true
  end
  it "An div is valid if both its keys are valid" do
    @div.valid?(@context.keys).should.be.true
  end
  it "An add is invalid if one key is invalid" do
    @add = Node::Add.new(@three, @invalid)
    @add.valid?(@context.keys).should.not.be.true
  end
  it "An sub is invalid if one key is invalid" do
    @sub = Node::Subtract.new(@three, @invalid)
    @sub.valid?(@context.keys).should.not.be.true
  end
  it "An mul is invalid if one key is invalid" do
    @mul = Node::Multiply.new(@three, @invalid)
    @mul.valid?(@context.keys).should.not.be.true
  end
  it "An div is invalid if one key is invalid" do
    @div = Node::Divide.new(@three, @invalid)
    @div.valid?(@context.keys).should.not.be.true
  end

  it "the value of a number is the number" do
    @three.value(@context).should == 3
    @seven.value(@context).should == 7
  end

  it "the value of a stat is looked up in the context" do
    @foo.value(@context).should == @context['foo']
    @bar.value(@context).should == @context['bar']
  end

  it "allows the use of an object in the context" do
    @foo.value(@class_context).should == @class_context.foo
  end

  it "raises an error on a missing context" do
    lambda { @bar.value(@class_context) }.should.raise(ExaltedMath::ContextError)
  end

  it "the value of an add is the sum of the two children" do
     @add.value(@context).should == 10
  end

  it "the value of an sub is first child minus the second" do
    @sub.value(@context).should == -4
  end

  it "the value of an mul is the two children multiplied together" do
    @mul.value(@context).should == 21
  end

  it "the value of a div is the first child divided by the second" do
    @div.value(@context).should == 2
  end

  it "the value of a min is the mininum value" do
    @min.value(@context).should == 3
  end
  it "the value of a max is the maxinum value" do
    @max.value(@context).should == 7
  end

  it "it walks the whole tree to compute a value" do
     @nested.value(@context).should == 0
  end

  it "can simplify a constant add" do
    @add.simplify.should == Node::Number.new(10)
  end

  it "A number is simple" do
    @three.simplify.should == Node::Number.new(3)
  end

  it "A stat is simple" do
    @foo.simplify.should == Node::Stat.new('foo')
  end

  it "A non-constant add isn't simplified" do
    @add_foo.simplify.should == Node::Add.new(@three, @foo)
  end
  it "A constant branches are simplified" do
    @nested.simplify.should == Node::Multiply.new(Node::Number.new(10), @sub_foo)
  end


  node_inequality Node::Number.new(1), Node::Number.new(2)
  node_inequality Node::Number.new(1), Node::Spec.new('foo')
  node_inequality Node::Number.new(1), Node::Stat.new('foo')
  node_inequality Node::Stat.new('bar'), Node::Stat.new('foo')
  node_inequality Node::Spec.new('foo'), Node::Stat.new('foo')
  node_inequality Node::Minimum.new([Node::Number.new(1), Node::Stat.new('foo')], 1), Node::Minimum.new([Node::Number.new(1), Node::Stat.new('foo')], 2)
  node_inequality Node::Maximum.new([Node::Number.new(1), Node::Stat.new('foo')], 1), Node::Maximum.new([Node::Number.new(1), Node::Stat.new('foo')], 2)
  node_inequality Node::Minimum.new([Node::Number.new(1), Node::Spec.new('foo')], 1), Node::Minimum.new([Node::Number.new(1), Node::Stat.new('foo')], 1)
  node_inequality Node::Minimum.new([Node::Number.new(1), Node::Spec.new('foo')], 1), Node::Maximum.new([Node::Number.new(1), Node::Spec.new('foo')], 1)

  node_equality Node::Number.new(1), Node::Number.new(1)
  node_equality Node::Spec.new('foo'), Node::Spec.new('foo')
  node_equality Node::Stat.new('foo'), Node::Stat.new('foo')
  node_equality Node::Minimum.new([Node::Number.new(1), Node::Stat.new('foo')], 1), Node::Minimum.new([Node::Number.new(1), Node::Stat.new('foo')], 1)
  node_equality Node::Maximum.new([Node::Number.new(1), Node::Stat.new('foo')], 1), Node::Maximum.new([Node::Number.new(1), Node::Stat.new('foo')], 1)
end

