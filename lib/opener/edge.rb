require 'enumerator'
require 'set'
require 'singleton'

require 'facets/kernel/returning'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :head
  attr_accessor :tails
  attr_accessor :node
  attr_accessor :move
  
  attr_accessor :games
  attr_accessor :transposition
  
  def self.instance(head = nil, move = nil)
    EDGES[head][move] &&  warn("Duplicate edge #{head} -> #{move}.")
    EDGES[head][move] ||= new(head, move)
  end
  
  #
  # Creates a new Edge connecting the +head+ edge and the tail node resulting
  # from +move+. 
  #
  def initialize(head = nil, move = nil)
    self.move  = move
    self.head  = head
    self.tails = Set.new
    self.node  = Opener::Node.instance(self.to_pgn)
  end
  
  def *(seen)
    self.games = games
    self
  end
  
  def +(wins)
    self.node.wins = wins
    self
  end
  
  def -(losses)
    self.node.losses = losses
    self
  end
  
  def |(annotation)
    self.node.annotation = annotation
    self
  end
  
  def ~
    self.transposition = true
    self
  end
  
  def moves
    @_moves ||= head ? (head.moves.dup << move) : []
  end
  
  def transposition?
    !! self.transposition
  end
  
  def to_pgn
    moves.enum_slice(2).enum_with_index.map do |(w, b), turn|
      "#{turn + 1}. #{w} #{b}"
    end.join(' ')
  end
  
  private
  
  def method_missing(move, name = nil, &block)
    move = move.to_s
    move.gsub!(/_/, '-')
    move.gsub!(/0/, 'O')
    
    returning self.class.instance(self, move, &block) do |edge|
     edge.node.name  = name
     self.tails     << edge
    end
  end
end
