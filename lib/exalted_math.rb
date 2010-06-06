#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'treetop'
require 'exalted_math/math'
require 'exalted_math/ast'

module Exalted
  class MathsParser
    def ast(text)
      result = parse(text)
      if result
        [true, result.ast]
      else
        [false, failure_reason]
      end
    end
  end
end
