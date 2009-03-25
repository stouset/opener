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
  attr_accessor :variation
  
  attr_accessor :parents
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  class << self
    remove_method :instance
  end
  
  def self.instance(edge)
    board = edge.to_epd
    
    NODES[board]         ||= new(board)
    NODES[board].parents  << edge
    NODES[board]
  end
  
  def initialize(board)
    self.board   = board
    self.parents = Set.new
  end
  
  def parent
    @_parent ||= begin
      if self.parents.all?(&:transposition?)
        warn 'No authoritative parent:'
        parents.each {|edge| warn "  #{edge.to_pgn}"}
      elsif self.parents.reject(&:transposition?).length > 1
        warn 'Inferred transpositions:'
        parents.each {|edge| warn "  #{edge.to_pgn}"}
      end
      
      parent = parents.reject(&:transposition?).first || parents.to_a.first
      parent.try(:head)
    end
  end
  
  def draws
    (100 - wins - losses) rescue nil
  end
  
  def stats
    [].tap do |stats|
      stats << "+%5.2f%" % wins   if wins
      stats << "=%5.2f%" % draws  if wins && losses
      stats << "-%5.2f%" % losses if losses
    end
  end
  
  def basename
    @_basename ||= case
      when self.name   then self.name.to_s.split(',').first
      when self.parent then self.parent.node.basename
      else                  ''
    end
  end
  
  def color
    self.parent.try(:halfturn?) ? '#000000' : '#cccccc'
  end
  
  def fillcolor
    self.class.colorize(self.basename)
  end
  
  def to_dot
    label = (variation || name).to_s.split(',')
    label.push(*stats)
    label.push(annotation)
    
    label = label.reject(&:blank?).map(&:strip).join('\n')
    
    group     = self.basename
    fillcolor = self.fillcolor
    color     = self.color
        
    %{ "#{self.board}" [ label     = "#{label}"
                         group     = "#{group}"
                         fillcolor = "#{fillcolor}"
                         color     = "#{color}"
                         style     = "filled" ] }
  end
  
  protected
  
  def self.colorize(name)
    color = Digest::MD5.hexdigest(name)[0..5]
    color = (color.to_i(16) + 0xffffff) / 2.0
    color = color.round.to_s(16)
    "##{color}"
  end
end
