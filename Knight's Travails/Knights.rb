require_relative "../poly_tree_node/skeleton/lib/00_tree_node.rb"

class KnightPathFinder
  
  def self.valid_moves(pos)
    #eight possible moves
    #show possible moves from given position
    #8 x 8 board
    possible_moves = []
    possible_moves << [pos.first - 2, pos.last + 1]
    possible_moves << [pos.first - 2, pos.last - 1]
    possible_moves << [pos.first - 1, pos.last + 2]
    possible_moves << [pos.first + 1, pos.last + 2]
    possible_moves << [pos.first + 2, pos.last + 1]
    possible_moves << [pos.first + 2, pos.last - 1]
    possible_moves << [pos.first + 1, pos.last - 2]
    possible_moves << [pos.first - 1, pos.last - 2]
    #filter invalid moves
    possible_moves.select do |move|
      (0...8).include?(move.first) && (0...8).include?(move.last)
    end
    
  end
  
  
  def initialize(start_pos)
    #call build tree 
    #start pos in format of [0,0]
    @visited_positions = []
    @visited_positions << start_pos
    build_move_tree
    
  end
  
  def new_move_positions(pos)
    #calls valid moves but filters moves alreayd in @visted poisions
    #adds reaminign new psoiitons to visited psoions and reutnr new psoitoins
    #based on the given pos, find new move positions
    next_moves = KnightPathFinder.valid_moves(pos)
    # puts "heres something to think about"
    # p @visited_positions
    # 
    
    possible_moves = next_moves - @visited_positions


    next_moves.each do |move|
      @visited_positions << move unless @visited_positions.include?(move)
    end

    # puts "new positions"
    possible_moves
    
    
  end
  

  
  # def find_path(target_pos)
  # 
  # end
  # 
  def build_move_tree
    # root_move = PolyTreeNode.new(@visited_positions.first)
    queue = []
    @root_node = PolyTreeNode.new(@visited_positions.first)
    queue << @root_node
    
    until queue.empty?
      cur_node = queue.shift

      new_move_positions(cur_node.value).each do |possible_move|
        child_node = PolyTreeNode.new(possible_move)
        cur_node.add_child(child_node)
        queue << child_node 
      end
      
    end
      
    @root_node
  end
  # 

  def find_path(end_pos)
    #find end pos in move tree
    #use trace_path_back
    @target_node = @root_node.bfs(end_pos)
    trace_path_back
  end
  
  def trace_path_back
    #recurse thru path via parent in array.
    node = @target_node
    path_list = []
    while !node.parent.nil?
      path_list.unshift(node.value)
      node = node.parent
    end
    path_list.unshift(node.value)
    
  end
  
end