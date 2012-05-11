#!/usr/bin/ruby
# Jonathan D. Stott <jonathan.stott@gmail.com>
require 'bacon'

Bacon.summary_on_exit

class Bacon::Context
  def node_inequality(left, right)
    it "`#{left.inspect}' != `#{right.inspect}`" do
      left.should.not == right
    end
  end
  def node_equality(left, right)
    it "`#{left.inspect}' == `#{right.inspect}`" do
      left.should == right
    end
  end
end
