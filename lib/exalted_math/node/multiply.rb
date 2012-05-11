#!/usr/bin/env ruby
require 'exalted_math/node/node'
require 'exalted_math/node/operator'
module ExaltedMath
  class Node
    class Multiply < Operator
      def value(context={})
        left.value(context) * right.value(context)
      end
    end
  end
end

