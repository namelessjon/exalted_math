#!/usr/bin/env ruby
require 'exalted_math/node/node'
module ExaltedMath
  class Node
    class Operator < Node
      attr_reader :left, :right

      def initialize(left, right)
        @left  = left
        @right = right
      end

      def constant?
        left.constant? and right.constant?
      end

      def value(context={})
        raise NotImplementedError
      end

      def simplify
        if constant?
          Number.new(value)
        else
          self.class.new(left.simplify, right.simplify)
        end
      end

      def ==(o)
        return false unless self.class === o
        left == o.left && right == o.right
      end

      def valid?(stats=[])
        left.valid?(stats) && right.valid?(stats)
      end
    end
  end
end
