#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
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
  end
  
  class NumberNode < Node
    def initialize(value)
      @value = value
    end
    
    def constant?
      true
    end
    
    def value(context={})
      @value
    end
  end
  
  class NamedNode < Node
    attr_reader :name
    def initialize(name)
      @name = name
    end
    
    def constant?
      false
    end
    
    def value(context={})
      context.fetch(name) { raise ContextError, name }
    end
  end
  
  class StatNode < NamedNode
  end
  
  class SpecNode < NamedNode
  end
  
  class OperatorNode < Node
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
        NumberNode.new(value)
      else
        self.class.new(left.simplify, right.simplify)
      end  
    end
  end
  
  class AddNode < OperatorNode
    def value(context={})
      left.value(context) + right.value(context)
    end
  end
  
  class SubtractNode < OperatorNode
    def value(context={})
      left.value(context) - right.value(context)
    end
  end
  
  class MultiplyNode < OperatorNode
    def value(context={})
      left.value(context) * right.value(context)
    end
  end
  
  class DivideNode < OperatorNode
    def value(context={})
      left.value(context) / right.value(context)
    end
  end
  
  class ListNode < Node
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
        NumberNode.new(value)
      else
        self
      end
    end
  end  
  
  class MaximumNode < ListNode
    attr_reader :count
    
    def initialize(nodes=[],count)
      super
      @count = count
    end
    
    def values(context={})
      nodes.map { |node| node.value(context) }.sort.slice(-count, count)
    end
  end
  
  class MinimumNode < ListNode
    attr_reader :count
    
    def initialize(nodes=[],count)
      super
      @count = count
    end
    
    def values(context={})
      nodes.map { |node| node.value(context) }.sort.slice(0, count)
    end
  end
end
