require 'facets/kernel/returning'
require 'facets/symbol/to_proc'

class Opener::Graph
  attr_accessor :root
  
  #
  # Initializes a new graph. The parameters passed are sent straight to parse.
  #
  def initialize(filename = nil, &block)
    self.root = Opener::Edge.instance
    
    parse(filename, &block)
  end
  
  #
  # Returns a subgraph starting at the board position given by the list of
  # moves.
  #
  def [](*moves)
    returning Opener::Graph.new do |graph|
      graph.root = self.root[*moves.map(&:to_sym)]
    end
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
end