class PolyTreeNode
  # attr_reader :parent, :children, :value
  def initialize(value)
      #sets values and starts parent as nil and children as empty array
      @parent = nil 
      @children = []
      @value = value
  end 
  # 
  def parent 
  #return nodes parents
    @parent
  end 
  
  def children
    #method returns array of children of a node
    @children
  end 
  
  def value 
    #method returns value stored at node
    @value
  end 
  # 
  def parent=(node)
    old_parent = @parent
    @parent = node
    
    if !node.nil? && !node.children.include?(self)
      node.children << self
      
      old_parent.children.delete(self) unless old_parent.nil?
    end
    
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise  "This ain't my child!" unless self.children.include?(child_node)
    child_node.parent = nil
  end
  
  def dfs(target_value)
    #recursive call to check value of children
    return self if self.value == target_value
    
    children.each do |child|
      # puts self.value
      result = child.dfs(target_value)
      if result != nil 
        return result
      end
    end
  
    return nil
  end
  
  def bfs(target_value)
    #create local array queue to search
    queue = []
    queue << self
    until queue.empty?
      next_up = queue.shift
      return next_up if target_value == next_up.value
      
      queue.concat(next_up.children)
    end
    return nil
  end
end