class PolyTreeNode
  attr_reader :position, :parent, :children

  def initialize(position)
    @position = position
    @parent = nil
    @children = []
  end

  def parent=(parent)
    self.parent.children.delete(self) unless self.parent.nil?
    @parent = parent
    return nil if parent == nil
    self.parent.children << self if !self.parent.children.include?(self)
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if self.children.include?(child)
      child.parent = nil 
    else
      raise
    end
  end

  def inspect
    @position.inspect
  end


  def dfs(target)
    return self if self.position == target 

    self.children.each do |child|
      found = child.dfs(target)
      return found if !found.nil?
    end

    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      found = queue.shift 
      return found if found.position == target
      queue += found.children
    end
    nil
  end
end