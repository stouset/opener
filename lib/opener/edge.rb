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
    self.node  = Opener::Node.instance(self.to_epd)
  end
  
  def [](*moves)
    move = moves.shift.to_sym
    edge = tails.detect {|edge| edge.move == move }
    
    moves.any? ? edge[*moves] : edge
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
  
  def turn
    (depth + 1) / 2
  end
  
  def halfturn?
    depth % 2 == 0
  end
  
  def transposition?
    !! self.transposition
  end
  
  def to_move
    "#{turn}".tap do |buffer|
       buffer << (halfturn? ? '...' : '. ')
       buffer << (self.move.to_s)
     end
  end
  
  def to_pgn
    moves.enum_slice(2).enum_with_index.map do |(w, b), turn|
      "#{turn + 1}. #{w} #{b}"
    end.join(' ').strip
  end
  
  def to_epd
    @_to_epd ||= %x{echo "#{self.to_pgn}" | ./bin/pgn2epd 2>/dev/null}.tap do |epd|
      raise "Invalid move: #{self.to_pgn}" if epd =~ %r{\n.*\n}
      epd.chomp!
      epd.sub!(/(\w\d)$/, '-')
    end if move
  end
  
  def to_dot
    if head
      label = self.to_move
      node  = self.node.to_dot
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
    # TODO: def me as an optimization?
    self.class.instance(self, pgnify(move)).tap do |edge|
      self.tails     << edge
      edge.node.name  = name
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
