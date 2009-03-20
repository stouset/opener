require 'singleton'

require 'facets/blank'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  attr_accessor :board
  attr_accessor :name
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  def self.instance(board)
    NODES[board] ||= new(board)
  end
  
  def initialize(board)
    self.board = board
  end
  
  def draws
    100 - wins - losses
  end
  
  def stats
    "+%5.2f%\n=%5.2f%\n-%5.2f%" % [wins, draws, losses] if (wins and losses)
  end
  
  def to_dot
    label = [
      name.to_s.split(',').map(&:strip).join('\n'),
      stats,
      annotation
    ].reject(&:blank?).join('\n').gsub(%r{\n}, '\n')
    %{ "#{self.board}" [label = "#{label}"] }.strip
  end
end
