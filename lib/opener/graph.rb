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
  
  def nodes
    root.nodes.uniq
  end
  
  def edges
    self.nodes.map(&:children).map(&:to_a).flatten
  end
  
  def inspect
    root.inspect
  end
  
  def to_s
    root.to_s
  end
  
  def to_dot
    nodes = self.nodes + self.ancestry.map(&:node)
    edges = self.edges + self.ancestry
    
    nodes.uniq!
    edges.sort!
    
    %( digraph Openings {
      ordering = "out"
      
      node [ fontname = "Monaco" ]
      edge [ fontname = "Monaco" ]
      
      #{nodes.map(&:to_dot).join("\n")}
      #{edges.map(&:to_dot).join("\n")}
    } )
  end
end