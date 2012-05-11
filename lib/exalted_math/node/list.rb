#!/usr/bin/env ruby
require 'exalted_math/node/node'
module ExaltedMath
  class Node
    class List < Node
      attr_reader :nodes

      def initialize(nodes=[],*)
        @nodes = nodes
      end

      def constant?
        nodes.all? { |n| n.constant? }
      end

      def values(context={})
        nodes.map { |node| node.value(context) }
      end

      def value(context={})
        values(context).inject(0) { |total, value| total += value }
      end

      def simplify
        if constant?
          Number.new(value)
        else
          self
        end
      end

      def ==(o)
        return false unless self.class === o
        nodes == o.nodes
      end
    end
  end
end
