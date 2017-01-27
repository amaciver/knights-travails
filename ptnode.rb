class PolyTreeNode

  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    @parent.children.delete(self) unless @parent.nil?
    @parent = node
    node.children << self unless node.nil? || node.children.include?(self)
  end

  def add_child(node)
    @children << node
    node.parent = self
  end

  def remove_child(node)
    if node.parent == self
      @children.delete(node)
      node.parent = nil
    else
      raise "that wasn't your chlid, man."
    end
  end

  


  def dfs(target)
    return self if self.value == target
    @children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      val = queue.shift
      return val if val.value == target
      queue += val.children
    end
    nil
  end

end
