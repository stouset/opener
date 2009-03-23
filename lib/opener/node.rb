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
        parents.each {|edge| warn " #{edge.to_pgn}"}
      elsif parents.length > 1
        warn 'Inferred transpositions:'
        parents.each {|edge| warn " #{edge.to_pgn}"}
      end
      
      parent = parents.detect {|e| not e.transposition? } || parents.to_a.first
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
  
  def color
    @_color ||= case
      when name   then ((Digest::MD5.hexdigest(name)[0..5].to_i(16) + 0xffffff) / 2).to_s(16)
      when parent then parent.node.color
      else             "f6f6f6"
    end
  end
  
  def to_dot
    label = [
      name.to_s.split(',').map(&:strip).join('\n'),
      stats.join('\n'),
      annotation
    ].reject(&:blank?).join('\n').gsub(%r{\n}, '\n')
    
    fillcolor = self.color
    color     = self.parent.try(:halfturn?) ? '000000' : 'ffffff'
        
    %{ "#{self.board}" [label="#{label}", fillcolor="##{fillcolor}" color="##{color}" style="filled"] }.strip
  end
end
