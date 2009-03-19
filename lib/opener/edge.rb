require 'singleton'

require 'facets/kernel/returning'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :head
  attr_accessor :tail
  attr_accessor :move
  
  attr_accessor :games
  
  def self.instance(head, move)
    EDGES[head][move] &&  warn("Duplicate edge #{head} -> #{move}.")
    EDGES[head][move] ||= new(head, move)
  end
  
  #
  # Creates a new Edge connecting the +head+ node and the tail after +move+. 
  #
  def initialize(head, move)
    self.move = move
    self.head = head
    self.tail = Opener::Node.new(self.to_epn)
  end
  
  def *(seen)
    self.games = games
  end
  
  def +(wins)
    self.tail.wins = wins
  end
  
  def -(losses)
    self.tail.losses = losses
  end
  
  def |(annotation)
    self.tail.annotation = annotation
  end
  
  private
  
  def method_missing(move, name = nil, &block)
    returning self.class.instance(self.tail, move, &block) do |edge|
      edge.tail.name = name
    end
  end
end
