require 'singleton'

class Opener::Node
  include Singleton
  
  NODES = {}
  
  attr_accessor :id
  
  def self.instance(id)
    NODES[id] ||= new(id)
  end
  
  def initialize(id)
    self.id = id
  end
end
