require 'enumerator'
require 'set'
require 'singleton'

require 'facets/blank'
require 'facets/enumerable/sum'
require 'facets/kernel/tap'

class Opener::Edge
  include Singleton
  
  EDGES = Hash.new {|h,k| h[k] = {} }
  
  attr_accessor :head
  attr_accessor :tails
  attr_accessor :node
  attr_accessor :move
  
  attr_writer   :games
  attr_accessor :transposition
  
  class << self
    remove_method :instance
  end
  
  def self.instance(head = nil, move = nil, name = nil)
    EDGES[head][move] ||= new(head, move, name)
  end
  
  #
  # Creates a new Edge connecting the +head+ edge and the tail node resulting
  # from +move+. 
  #
  def initialize(head = nil, move = nil, name = nil)
    self.move  = move
    self.head  = head
    self.tails = Set.new
    self.node  = Opener::Node.instance(self, name)
  end
  
  def [](*moves)
    if moves.any?
      move = moves.shift.to_sym
      edge = tails.detect {|edge| edge.move == move }
    
      moves.any? ? edge[*moves] : edge
    else
      self
    end
  end
  
  def *(seen)
    self.games = seen
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
  
  def games
    @games ||= self.tails.sum(&:games)
  end
  
  def moves
    @_moves ||= head ? (head.moves.dup << move) : []
  end
  
  def depth
    @_depth ||= head ? head.depth + 1 : 0
  end
  
  def frequency
    unless self.games.zero? or self.head.games.zero?
      '%.2f%' % (self.games.to_f / self.head.games * 100)
    end
  end
  
  def turn
    (depth + 1) / 2
  end
  
  def halfturn?
    depth % 2 == 0
  end
  
  def transposition?
    !! self.transposition
  end
  
  def ancestry
    self.head ? self.head.ancestry + [self.head.node, self.head] : []
  end
  
  def tree
    [self.node, self] + self.tails.map(&:tree).flatten
  end
  
  def to_move
    "#{turn}".tap do |buffer|
       buffer << (halfturn? ? '...' : '. ')
       buffer << (self.move.to_s)
     end
  end
  
  def to_pgn
    self.moves.enum_slice(2).enum_with_index.map do |(w, b), turn|
      "#{turn + 1}. #{w} #{b}"
    end.join(' ').gsub(%r{[!?]}, '').strip
  end
  
  def to_epd
    pgn2epd(self.to_pgn)
  end
  
  def to_dot
    if head
      label = [self.to_move, self.frequency].join('\n')
      head  = self.head.to_epd
      epd   = self.to_epd
      
      %{ "#{head}" -> "#{epd}" [label = "#{label}"] }.strip
    end
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
    self.class.instance(self, pgnify(move), name).tap do |edge|
      self.tails << edge
      edge.instance_eval(&block) if block_given?
    end
  end
  
  def pgnify(move)
    move.to_s.tap do |move|
      move.gsub!(/_/, '-')
      move.gsub!(/0/, 'O')
    end.to_sym
  end
end
