require 'enumerator'
require 'set'
require 'singleton'

require 'facets/blank'
require 'facets/kernel/tap'

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
  
  def [](*moves)
    move = moves.shift.to_sym
    edge = tails.detect {|edge| edge.move == move }
    
    moves.any? ? edge[*moves] : edge
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
    end.join(' ').strip
  end
  
  def to_epn
  end
  
  def to_s
    to_pgn
  end
  
  def inspect
    self.to_pgn.dup.tap do |pgn|
      metadata = [node.name, node.annotation].compact.join(', ')
      choices  = self.tails.map(&:move)
      
      pgn << " (#{metadata})" unless metadata.blank?
      pgn << " -> #{choices.inspect}"
    end
  end
  
  private
  
  def method_missing(move, name = nil, &block)
    self.class.instance(self, pgnify(move), &block).tap do |edge|
      edge.node.name  = name
      self.tails     << edge
    end
  end
  
  def pgnify(move)
    move.to_s.tap do |move|
      move.gsub!(/_/, '-')
      move.gsub!(/0/, 'O')
    end.to_sym
  end
end
