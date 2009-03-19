require 'enumerator'
require 'singleton'

require 'facets/kernel/returning'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :head
  attr_accessor :tail
  attr_accessor :move
  
  attr_accessor :games
  attr_accessor :transposition
  
  def self.instance(head = nil, move = nil)
    EDGES[head][move] &&  warn("Duplicate edge #{head} -> #{move}.")
    EDGES[head][move] ||= new(head, move)
  end
  
  #
  # Creates a new Edge connecting the +head+ node and the tail after +move+. 
  #
  def initialize(head = nil, move = nil)
    self.move = move
    self.head = head
    self.tail = Opener::Node.instance(self.to_epn)
  end
  
  def *(seen)
    self.games = games
    self
  end
  
  def +(wins)
    self.tail.wins = wins
    self
  end
  
  def -(losses)
    self.tail.losses = losses
    self
  end
  
  def |(annotation)
    self.tail.annotation = annotation
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
      edge.tail.name   = name
      edge.tail.edges << self
    end
  end
end
