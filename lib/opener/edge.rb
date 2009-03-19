require 'singleton'

require 'facets/kernel/returning'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :parent
  attr_accessor :child
  
  def self.instance(parent, move)
    EDGES[parent][move] &&  warn("Duplicate edge #{parent} -> #{move}.")
    EDGES[parent][move] ||= new(parent, move)
  end
  
  #
  # Creates a new Edge connecting the +parent+ node and the node after +move+. 
  #
  def initialize(parent, move)
    self.parent = parent
    self.child  = Opener::Node.new(parent.moves + [move])
  end
  
  private
  
  def method_missing(move, name = nil, &block)
    returning self.class.instance(self.child, move, &block) do |edge|
      edge.child.name = name
    end
  end
end
