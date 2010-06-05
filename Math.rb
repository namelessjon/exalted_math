# Autogenerated from a Treetop grammar. Edits may be lost.
require 'treetop'

module ExaltedMaths
  include Treetop::Runtime

  def root
    @root ||= :additive
  end

  module Additive0
    def multitive
      elements[0]
    end

    def additive
      elements[4]
    end
  end

  module Additive1
    def value
      multitive.value + additive.value
    end
  end

  module Additive2
    def multitive
      elements[0]
    end

    def additive
      elements[4]
    end
  end

  module Additive3
    def value
      multitive.value - additive.value
    end
  end

  def _nt_additive
    start_index = index
    if node_cache[:additive].has_key?(index)
      cached = node_cache[:additive][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_multitive
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        r4 = _nt_space
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
      if r3
        if has_terminal?('+', false, index)
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('+')
          r5 = nil
        end
        s1 << r5
        if r5
          s6, i6 = [], index
          loop do
            r7 = _nt_space
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          s1 << r6
          if r6
            r8 = _nt_additive
            s1 << r8
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Additive0)
      r1.extend(Additive1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_multitive
      s9 << r10
      if r10
        s11, i11 = [], index
        loop do
          r12 = _nt_space
          if r12
            s11 << r12
          else
            break
          end
        end
        r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
        s9 << r11
        if r11
          if has_terminal?('-', false, index)
            r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('-')
            r13 = nil
          end
          s9 << r13
          if r13
            s14, i14 = [], index
            loop do
              r15 = _nt_space
              if r15
                s14 << r15
              else
                break
              end
            end
            r14 = instantiate_node(SyntaxNode,input, i14...index, s14)
            s9 << r14
            if r14
              r16 = _nt_additive
              s9 << r16
            end
          end
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(Additive2)
        r9.extend(Additive3)
      else
        @index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        r17 = _nt_multitive
        if r17
          r0 = r17
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:additive][start_index] = r0

    r0
  end

  module Multitive0
    def primary
      elements[0]
    end

    def multitive
      elements[4]
    end
  end

  module Multitive1
    def value
      primary.value * multitive.value
    end
  end

  module Multitive2
    def primary
      elements[0]
    end

    def multitive
      elements[4]
    end
  end

  module Multitive3
    def value
      primary.value / multitive.value
    end
  end

  def _nt_multitive
    start_index = index
    if node_cache[:multitive].has_key?(index)
      cached = node_cache[:multitive][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    r2 = _nt_primary
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        r4 = _nt_space
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
      if r3
        if has_terminal?('*', false, index)
          r5 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure('*')
          r5 = nil
        end
        s1 << r5
        if r5
          s6, i6 = [], index
          loop do
            r7 = _nt_space
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          s1 << r6
          if r6
            r8 = _nt_multitive
            s1 << r8
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Multitive0)
      r1.extend(Multitive1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      i9, s9 = index, []
      r10 = _nt_primary
      s9 << r10
      if r10
        s11, i11 = [], index
        loop do
          r12 = _nt_space
          if r12
            s11 << r12
          else
            break
          end
        end
        r11 = instantiate_node(SyntaxNode,input, i11...index, s11)
        s9 << r11
        if r11
          if has_terminal?('/', false, index)
            r13 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure('/')
            r13 = nil
          end
          s9 << r13
          if r13
            s14, i14 = [], index
            loop do
              r15 = _nt_space
              if r15
                s14 << r15
              else
                break
              end
            end
            r14 = instantiate_node(SyntaxNode,input, i14...index, s14)
            s9 << r14
            if r14
              r16 = _nt_multitive
              s9 << r16
            end
          end
        end
      end
      if s9.last
        r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
        r9.extend(Multitive2)
        r9.extend(Multitive3)
      else
        @index = i9
        r9 = nil
      end
      if r9
        r0 = r9
      else
        r17 = _nt_primary
        if r17
          r0 = r17
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:multitive][start_index] = r0

    r0
  end

  module Primary0
    def additive
      elements[2]
    end

  end

  module Primary1
    def value
      additive.value
    end
  end

  def _nt_primary
    start_index = index
    if node_cache[:primary].has_key?(index)
      cached = node_cache[:primary][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    i1, s1 = index, []
    if has_terminal?('(', false, index)
      r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
      @index += 1
    else
      terminal_parse_failure('(')
      r2 = nil
    end
    s1 << r2
    if r2
      s3, i3 = [], index
      loop do
        r4 = _nt_space
        if r4
          s3 << r4
        else
          break
        end
      end
      r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
      s1 << r3
      if r3
        r5 = _nt_additive
        s1 << r5
        if r5
          s6, i6 = [], index
          loop do
            r7 = _nt_space
            if r7
              s6 << r7
            else
              break
            end
          end
          r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
          s1 << r6
          if r6
            if has_terminal?(')', false, index)
              r8 = instantiate_node(SyntaxNode,input, index...(index + 1))
              @index += 1
            else
              terminal_parse_failure(')')
              r8 = nil
            end
            s1 << r8
          end
        end
      end
    end
    if s1.last
      r1 = instantiate_node(SyntaxNode,input, i1...index, s1)
      r1.extend(Primary0)
      r1.extend(Primary1)
    else
      @index = i1
      r1 = nil
    end
    if r1
      r0 = r1
    else
      r9 = _nt_number
      if r9
        r0 = r9
      else
        r10 = _nt_spec
        if r10
          r0 = r10
        else
          r11 = _nt_max
          if r11
            r0 = r11
          else
            r12 = _nt_stat
            if r12
              r0 = r12
            else
              @index = i0
              r0 = nil
            end
          end
        end
      end
    end

    node_cache[:primary][start_index] = r0

    r0
  end

  module Spec0
    def speciality
      elements[4]
    end

  end

  module Spec1
    def value
      puts speciality.text_value
      1
    end
  end

  def _nt_spec
    start_index = index
    if node_cache[:spec].has_key?(index)
      cached = node_cache[:spec][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[Ss]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      if has_terminal?('pec', false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 3))
        @index += 3
      else
        terminal_parse_failure('pec')
        r2 = nil
      end
      s0 << r2
      if r2
        if has_terminal?('iality', false, index)
          r4 = instantiate_node(SyntaxNode,input, index...(index + 6))
          @index += 6
        else
          terminal_parse_failure('iality')
          r4 = nil
        end
        if r4
          r3 = r4
        else
          r3 = instantiate_node(SyntaxNode,input, index...index)
        end
        s0 << r3
        if r3
          if has_terminal?(':"', false, index)
            r5 = instantiate_node(SyntaxNode,input, index...(index + 2))
            @index += 2
          else
            terminal_parse_failure(':"')
            r5 = nil
          end
          s0 << r5
          if r5
            r6 = _nt_speciality
            s0 << r6
            if r6
              if has_terminal?('"', false, index)
                r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
                @index += 1
              else
                terminal_parse_failure('"')
                r7 = nil
              end
              s0 << r7
            end
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Spec0)
      r0.extend(Spec1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:spec][start_index] = r0

    r0
  end

  def _nt_speciality
    start_index = index
    if node_cache[:speciality].has_key?(index)
      cached = node_cache[:speciality][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[^"]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:speciality][start_index] = r0

    r0
  end

  module Max0
  end

  module Max1
  end

  module Max2
    def value
      1
    end
  end

  def _nt_max
    start_index = index
    if node_cache[:max].has_key?(index)
      cached = node_cache[:max][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('max(', false, index)
      r1 = instantiate_node(SyntaxNode,input, index...(index + 4))
      @index += 4
    else
      terminal_parse_failure('max(')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        i4 = index
        r5 = _nt_number
        if r5
          r4 = r5
        else
          r6 = _nt_stat
          if r6
            r4 = r6
          else
            @index = i4
            r4 = nil
          end
        end
        s3 << r4
        if r4
          if has_terminal?(',', false, index)
            r7 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(',')
            r7 = nil
          end
          s3 << r7
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Max0)
        else
          @index = i3
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
      if r2
        i8 = index
        r9 = _nt_number
        if r9
          r8 = r9
        else
          r10 = _nt_stat
          if r10
            r8 = r10
          else
            @index = i8
            r8 = nil
          end
        end
        s0 << r8
        if r8
          if has_terminal?(')', false, index)
            r11 = instantiate_node(SyntaxNode,input, index...(index + 1))
            @index += 1
          else
            terminal_parse_failure(')')
            r11 = nil
          end
          s0 << r11
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Max1)
      r0.extend(Max2)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:max][start_index] = r0

    r0
  end

  def _nt_space
    start_index = index
    if node_cache[:space].has_key?(index)
      cached = node_cache[:space][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      i1 = index
      if has_terminal?(" ", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(" ")
        r2 = nil
      end
      if r2
        r1 = r2
      else
        if has_terminal?("\t", false, index)
          r3 = instantiate_node(SyntaxNode,input, index...(index + 1))
          @index += 1
        else
          terminal_parse_failure("\t")
          r3 = nil
        end
        if r3
          r1 = r3
        else
          @index = i1
          r1 = nil
        end
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:space][start_index] = r0

    r0
  end

  module Number0
  end

  module Number1
    def value
      text_value.to_i
    end
  end

  def _nt_number
    start_index = index
    if node_cache[:number].has_key?(index)
      cached = node_cache[:number][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[1-9]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[0-9]', true, index)
          r3 = true
          @index += 1
        else
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Number0)
      r0.extend(Number1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:number][start_index] = r0

    r0
  end

  module Stat0
    def value
      puts text_value
      text_value.size
    end
  end

  def _nt_stat
    start_index = index
    if node_cache[:stat].has_key?(index)
      cached = node_cache[:stat][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?('\G[A-Za-z]', true, index)
        r1 = true
        @index += 1
      else
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Stat0)
    end

    node_cache[:stat][start_index] = r0

    r0
  end

end

class ExaltedMathsParser < Treetop::Runtime::CompiledParser
  include ExaltedMaths
end


@foo = ExaltedMathsParser.new
loop do
end
