require 'singleton'

require 'facets/kernel/returning'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :parent
  attr_accessor :child
  
  def self.instance(parent, move)
    EDGES[parent][move] &&  warn 'Duplicate edge: #{parent} -> #{move}' 
    EDGES[parent][move] ||= new(parent, move)
  end
  
  def initialize(parent, move)
    self.parent = parent
    self.child  # = Opener::Node.new(parent.moves + [move])
  end
  
  private
  
  def warn(message)
    STDERR.puts "Warning: #{message}"
  end
  
  def method_missing(move, name = nil, &block)
    returning self.class.instance(self.node, move, &block) do |edge|
      edge.child.name = name
    end
  end
end