require 'facets/kernel/returning'
require 'facets/symbol/to_proc'

class Opener::Graph
  attr_accessor :root
  
  #
  # Initializes a new graph. The parameters passed are sent straight to parse.
  #
  def initialize(filename = nil, &block)
    parse(filename, &block)
  end
  
  #
  # Returns a subgraph starting at the board position given by the list of
  # moves.
  #
  def [](*moves)
    if node = self.root[*moves.map(&:to_sym)]
      Opener::Graph.new.tap {|g| g.root = node }
    end
  end
  
  def root
    @root ||= Opener::Edge.instance
  end
  
  #
  # Parses the moves provided in +io+ and the block passed. Either, neither,
  # or both of the block and IO arguments can be provided.
  #
  def parse(io = nil, &block)
    root.instance_eval(io.read) if io
    root.instance_eval(&block)  if block_given?
    self
  end
  
  def tree
    root.tree
  end
  
  def inspect
    root.inspect
  end
  
  def to_s
    root.to_s
  end
  
  def to_dot
    %( digraph Openings {
      node [ fontname = "Monaco" ]
      edge [ fontname = "Monaco" ]
      
      #{self.tree.map(&:to_dot).join("\n")}
    } )
  end
end