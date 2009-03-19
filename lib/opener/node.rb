require 'singleton'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  attr_accessor :id
  attr_accessor :parents
  attr_accessor :name
  
  attr_accessor :wins
  attr_accessor :losses
  attr_accessor :annotation
  
  def self.instance(id)
    NODES[id] ||= new(id)
  end
  
  def initialize(id)
    self.id      = id
    self.parents = []
  end
end
