#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'treetop/runtime'
require 'exalted_math/math'
require 'exalted_math/node'

module ExaltedMath

  class ContextError < StandardError; end
  class ParseFailedError < StandardError; end
  class MathsParser
    def ast(text)
      txt = text.dup
      txt.strip!
      txt.gsub!(/\s+/," ")
      result = parse(txt)
      if result
        result.ast
      else
        raise ParseFailedError, failure_reason
      end
    end
  end
end
