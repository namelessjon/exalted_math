#!/usr/bin/env ruby
require 'exalted_math/node/node'
module ExaltedMath
  class Node
    class Named < Node
      attr_reader :name
      def initialize(name)
        @name = name
      end

      def constant?
        false
      end

      def value(context={})
        if context.respond_to?(:fetch)
          context.fetch(name) { raise ContextError, name }
        elsif context.respond_to?(name)
          context.public_send(name)
        else
          raise ContextError, name
        end
      end

      def ==(o)
        return false unless self.class === o
        self.name == o.name
      end

      def valid?(stats)
        stats.include?(name)
      end
    end

    class Stat < Named
    end

    class Spec < Named
    end

  end
end
