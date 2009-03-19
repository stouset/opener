require 'singleton'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  attr_accessor :board
  attr_accessor :edges
  attr_accessor :name
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  def self.instance(board)
    NODES[board] ||= new(board)
  end
  
  def initialize(board)
    self.board = board
    self.edges = []
  end
end
