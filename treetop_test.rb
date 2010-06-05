#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'treetop'
puts 'Loaded Treetop with no problems...'

Treetop.load 'Math'
puts 'Loaded math grammar with no problems...'

parser = ExaltedMathsParser.new

print "You say: "; what_you_said = gets
what_you_said.strip! # remove the newline at the end
p what_you_said

class InputProxy
  attr_reader :context

  def initialize(input, context)
    @input = input
    @context = context
  end

  def length
    @input.length
  end

  def size
    length
  end

  def [](*a)
    @input[*a]
  end

  def index(*a)
    @input.index(*a)
  end

  def line_of(x)
    @input.line_of(x)
  end

  def column_of(x)
    @input.column_of(x)
  end
end

wys = InputProxy.new(what_you_said, 1)

if result = parser.parse(wys)
  puts "I say yes! I understand!"
  puts "-----"
  p result.value
else
  puts "I say no, I don't understand."
  puts parser.failure_reason
end
