require_relative "node"

class Tree
  
  attr_accessor :input_array, :root

  def initialize(input_array, root = nil)
    @input_array = input_array.sort!.uniq!
    @root = build_tree
  end

  def build_tree
    if base case to check if we're at the end of the tree, then return nil maybe?
    
    else 
      root = middle element of the array
      call build_tree recursively for the left side of the tree
      call build_tree recursively for the right side of the tree
      return root
    
  end

end

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(test_array)
tree.build_tree
