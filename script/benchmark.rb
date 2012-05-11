#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
$LOAD_PATH.unshift 'lib'
require 'exalted_math'

CONTEXT = { 'essence' => 4, 'willpower' => 9, 'compassion' => 4, 'conviction' => 3, 'temperance' => 4, 'valor' => 2 }.freeze

string = '(Essence * 4) + Willpower + highest[2](compassion,conviction,temperance,valor) + 11'.gsub(/\s/,'')
times = []

5.times do
start = Time.now
10_000.times do
  ExaltedMath::MathsParser.new.ast(string)
end
end_time   = Time.now
times << end_time - start
end

sum = times.inject(0.0) { |total, time| total += time }

puts times
puts "Average: #{sum/times.size}"
