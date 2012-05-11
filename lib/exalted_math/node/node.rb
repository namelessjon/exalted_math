#!/usr/bin/env ruby
module ExaltedMath
  class Node
    def initialize(*)
    end

    def constant?
      true
    end

    def value(context={})
      nil
    end

    def simplify
      self
    end

    def valid?(*)
      false
    end
  end
end
