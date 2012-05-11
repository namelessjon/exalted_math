#!/usr/bin/env ruby
require 'exalted_math/node/node'
module ExaltedMath
  class Node
    class Number < Node
      def initialize(value)
        @value = value
      end

      def constant?
        true
      end

      def value(context={})
        @value
      end

      def ==(o)
        return false unless self.class === o
        @value == o.value
      end

      def valid?(*)
        true
      end
    end
  end
end
