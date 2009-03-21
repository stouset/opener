require 'digest/md5'
require 'set'
require 'singleton'

require 'facets/blank'
require 'facets/kernel/try'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  attr_accessor :board
  attr_accessor :name
  
  attr_accessor :parents
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  def self.instance(board)
    NODES[board] ||= new(board)
  end
  
  def initialize(board)
    self.board   = board
    self.parents = Set.new
  end
  
  def parent
    @_parent ||= begin
      parents = self.parents.to_a
      parents = parents.all?(&:transposition?) ? [parents.first] : parents.reject(&:transposition?)
      parent  = parents.first.head if parents.any? && parents.first.head
      
      if parents.length > 1
        warn "Unflagged transpositions:"
        parents.each {|edge| warn "  #{edge.to_pgn}" }
      end
      
      parent
    end
  end
  
  def draws
    100 - wins - losses
  end
  
  def stats
    [ "+%5.2f%" % wins,
      "=%5.2f%" % draws,
      "-%5.2f%" % losses ] if (wins and losses)
  end
  
  def to_dot
    label = [
      name.to_s.split(',').map(&:strip).join('\n'),
      stats.join('\n'),
      annotation
    ].reject(&:blank?).join('\n').gsub(%r{\n}, '\n')
    %{ "#{self.board}" [label = "#{label}"] }.strip
  end
end
