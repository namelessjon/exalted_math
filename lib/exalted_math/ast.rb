#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
module Exalted
  # Provides a simple AST for Exalted Maths
  class Ast < Array
    class UnknownNodeError < ArgumentError
      def initialize(type)
        @message = "Unknown node type '#{type}'"
        puts @message
      end
    end

    def initialize(*args)
      super(args)
    end

    # Is this AST constant?
    #
    # If an AST only has constant child nodes, it is constant.
    # This allows some simplification.
    #
    # @return [Boolean] is the AST constant
    def constant?
      case self[0]
      when 'mul', 'div', 'add', 'sub'
        self[1].constant? and self[2].constant?
      when 'num'
        true
      when 'stat', 'spec'
        false
      when 'max'
        self[2].all? { |ast| ast.constant? }
      else
        raise UnknownNodeError, self[0]
      end
    end

    # Is the given AST constant?
    #
    # If an AST only has constant child nodes, it is constant.
    # This allows some simplification.
    #
    # @param ast [Ast] An Ast
    #
    # @return [Boolean] is the AST constant
    def self.constant?(ast)
      ast.constant?
    end

    # Is the given AST valid?
    #
    # Does the context provide all the values the AST is looking for?
    #
    # @param ast [Ast] The Ast to test
    # @param valid_values [Array] Array of valid values, the keys of the context
    # @param errors [Array] Optional array of errors
    #
    # @return [Boolean] True if valid, false if not.
    def self.valid?(ast, valid_values, errors=[])
      case ast[0]
      when 'mul', 'div', 'add', 'sub'
        valid?(ast[1], valid_values, errors) and valid?(ast[2], valid_values, errors)
      when 'num'
        true
      when 'stat', 'spec'
        if valid_values.include? ast[1]
          true
        else
          errors << "Unknown #{ast[0]} '#{ast[1]}'"
          false
        end
      when 'max', 'min'
        ast[2].map { |ast| valid?(ast, valid_values, errors) }.all?
      else
        raise UnknownNodeError, ast[0]
      end
    end

    # Calculate the value of the AST for the given context
    #
    # This method recursively walks the AST, calculating the final value
    #
    # @param ast [Ast] The AST to compute
    # @param context [#[]] Context used to evaluate the AST
    #
    # @return [Integer] The value of the AST
    def self.value(ast, context={})
      case ast[0]
      when 'mul'
        value(ast[1], context) * value(ast[2], context)
      when 'div'
        value(ast[1], context) / value(ast[2], context)
      when 'add'
        value(ast[1], context) + value(ast[2], context)
      when 'sub'
        value(ast[1], context) - value(ast[2], context)
      when 'num'
        ast[1]
      when 'stat', 'spec'
        context[ast[1]]
      when 'max'
        tmp = ast[2].map { |ast| value(ast, context) }.sort[-ast[1], ast[1]]
        (tmp.size == 1) ? tmp.first : tmp.inject(0) { |fin, val| fin += val }
      when 'min'
        tmp = ast[2].map { |ast| value(ast, context) }.sort[0, ast[1]]
        (tmp.size == 1) ? tmp.first : tmp.inject(0) { |fin, val| fin += val }
      else
        raise UnknownNodeError, self[0]
      end
    end

    # Simplify the AST
    #
    # This recusively walks the AST, replacing any constant subtrees with their
    # value.
    #
    # @param ast [Ast] The AST to simplify
    # @return [Ast] The simplified AST
    def self.simplify(ast)
      if ast.constant?
        new('num', value(ast))
      else
        case ast[0]
        when 'add', 'sub', 'mul', 'div'
           new(ast[0], simplify(ast[1]), simplify(ast[2]))
        else
          ast
        end
      end
    end

    def self.from_array(array)
      case array[0]
      when 'mul', 'div', 'add', 'sub'
        new(array[0], from_array(array[1]), from_array(array[2])  )
      when 'num', 'stat', 'spec'
        new(array[0], array[1])
      when 'max', 'min'
        new(array[0], array[1], array[2].map! { |ast| new(ast) } )
      else
        raise UnknownNodeError, self[0]
      end
    end
  end
end
