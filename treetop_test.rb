#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'exalted_math'
require 'pp'

parser = Exalted::MathsParser.new

what_you_said = gets
what_you_said.strip! # remove the newline at the end
p what_you_said
puts "-----"

hash = {'willpower' => 9, 'essence' => 4, 'compassion' => 4, 'conviction' => 3, 'temperance' => 4, 'valor' => 2}

success, result = parser.ast(what_you_said)
if success
  pp result
  errors = []
  if valid = Exalted::Ast.valid?(result, hash.keys, errors)
    puts Exalted::Ast.value(result, hash)
  else
    puts "Problem with node:"
    pp errors
  end
else
  puts result
end
