require 'facets/kernel/returning'
require 'facets/symbol/to_proc'

class Opener::Graph
  attr_writer :root
  
  #
  # Initializes a new graph. The parameters passed are sent straight to parse.
  #
  def initialize(*filenames, &block)
    filenames.each {|f| self.parse(f, &block) }
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
    root.instance_eval(io.read, io.path, 1) if io
    root.instance_eval(&block)              if block_given?
    self
  end
  
  def ancestry
    root.ancestry
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
    graph = self.ancestry + self.tree
    nodes = graph.select   {|o| o.kind_of?(Opener::Node) }.uniq
    edges = graph.select   {|o| o.kind_of?(Opener::Edge) }
    edges = edges.sort_by {|e| (not e.transposition?) ? 0 : 1 }
    
    %( digraph Openings {
      ordering = "out"
      
      node [ fontname = "Monaco" ]
      edge [ fontname = "Monaco" ]
      
      #{nodes.map(&:to_dot).join("\n")}
      #{edges.map(&:to_dot).join("\n")}
    } )
  end
end