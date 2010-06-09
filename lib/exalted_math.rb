#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'treetop/runtime'
require 'exalted_math/math'
require 'exalted_math/ast'

module Exalted
  class MathsParser
    def ast(text)
      txt = text.dup
      txt.strip!
      txt.gsub!(/\s+/," ")
      result = parse(txt)
      if result
        [true, result.ast]
      else
        [false, failure_reason]
      end
    end
  end
end
