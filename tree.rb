require_relative "node"

class Tree
  
  attr_accessor :root

  def initialize(input_array, root = nil)
    @input_array = input_array
    @root = build_tree
  end

  def build_tree(array = @input_array, start = 0, ending = (array.size - 1))
    if start > ending
      nil
    else 
      middle = (start + ending) / 2
      root = Node.new(array[middle])
      root.left_child = build_tree(array, start, middle - 1)
      root.right_child = build_tree(array, middle + 1, ending)
    end
    root
  end

end

test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
test_array.sort!.uniq!
p test_array
tree = Tree.new(test_array)
root_node = tree.root
p root_node.data_stored