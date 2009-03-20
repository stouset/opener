require 'singleton'

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
    "+#{wins}%\n=#{draws}%\n-#{losses}%" if (wins and losses)
  end
  
  def to_dot
    label = [ name, stats, annotation ].compact.join('\n')
    %{ "#{self.board}" [label = "#{label}"] }.strip
  end
end
