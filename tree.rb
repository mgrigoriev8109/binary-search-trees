require_relative "node"

class Tree
  
  attr_accessor :root

  def initialize(input_array, root = nil)
    @input_array = input_array
    @root = build_tree(@input_array)
  end

  def build_tree(array, start_index = 0, end_index = (array.size - 1))
    if start_index > end_index
      nil
    else 
      middle_index = (start_index + end_index) / 2
      p "node.data_stored == #{array[middle_index]}"
      root = Node.new(array[middle_index])
      root.left_child = build_tree(array, start_index, middle_index - 1)
      root.right_child = build_tree(array, middle_index + 1, end_index)
    end
    root
  end

  def insert(value, root)
    if root.nil?
      root = Node.new(value)
    elsif value < root.data_stored
      root.left_child = insert(value, root.left_child)
    else
      root.right_child = insert(value, root.right_child)
    end
    root
  end
end

test_array = [1, 2, 3, 4, 5, 6, 8]
test_array.sort!.uniq!
p "The test array is #{test_array}"
p "A vertical view of the balanced binary search tree:"
tree = Tree.new(test_array)
root_node = tree.root
p "The level 0 root node has a value of #{root_node.data_stored}"
tree.insert(7, root_node)
