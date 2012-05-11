#!/usr/bin/env ruby
require 'exalted_math/node/node'
require 'exalted_math/node/list'
module ExaltedMath
  class Node
    class Minimum < List
      attr_reader :count

      def initialize(nodes=[],count)
        super
        @count = count
      end

      def values(context={})
        nodes.map { |node| node.value(context) }.sort.slice(0, count)
      end

      def ==(o)
        return false unless super
        count == o.count
      end
    end
  end
end
