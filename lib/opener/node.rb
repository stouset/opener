require 'digest/md5'
require 'set'
require 'singleton'

require 'facets/blank'
require 'facets/kernel/try'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  BLACK = '#000000'
  WHITE = '#cccccc'
  EMPTY = '#f0f0f0'
  
  attr_accessor :board
  attr_accessor :opening
  attr_accessor :variation
  
  attr_accessor :parents
  attr_accessor :children
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  class << self
    remove_method :instance
  end
  
  def self.instance(board)
    NODES[board] ||= new(board)
  end
  
  def initialize(board)
    self.board    = board
    self.parents  = Set.new
    self.children = Set.new
  end
  
  def parent
    @_parent ||= begin
      if self.transposition?
        warn 'No authoritative parent:'
        parents.each {|edge| warn "  #{edge.to_pgn}" }
      elsif self.parents.reject(&:transposition?).length > 1
        warn 'Inferred transpositions:'
        parents.each {|edge| warn "  #{edge.to_pgn}" }
      end
    
      parent = parents.reject(&:transposition?).first || parents.to_a.first
      parent.try(:head)
    end
  end
  
  def transposition?
    self.parents.any? and self.parents.all?(&:transposition?)
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
  
  def name=(name)
    if !self.name.blank? && self.name.class == name.class
      warn "Renaming #{self.name} to #{name}"
    end
    
    case name
      when String then self.opening   = name
      when Symbol then self.variation = name.to_s
    end
  end
  
  def name
    self.opening || self.variation
  end
  
  def group
    case
      when self.opening then self.opening.gsub %r{\(.*?\)}, ''
      when self.parent  then self.parent.node.group
      else                  ''
    end
  end
  
  def color
    self.parent.try(:halfturn?) ? BLACK : WHITE
  end
  
  def fillcolor
    self.class.colorize(self.group)
  end
  
  def to_dot
    label = [(self.opening || self.group), self.variation.to_s].compact
    label.push(*stats)
    label.push(annotation)
    
    label = label.reject(&:blank?).map(&:strip).join('\n')
    
    group     = self.group
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
    unless name.blank?
      color = Digest::MD5.hexdigest(name)[0..5]
      color = (color.to_i(16) + 0xffffff) / 2.0
      color = color.round.to_s(16)
      "##{color}"
    else
      EMPTY
    end
  end
end
