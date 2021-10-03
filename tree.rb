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

  def traverse_tree(callback_method, value, root)
    if value < root.data_stored
      root.left_child = callback_method.call(value, root.left_child)
    else
      root.right_child = callback_method.call(value, root.right_child)
    end
  end

  def insert(value, root)
    if root.nil?
      root = Node.new(value)
    else
      traverse_tree(method(:insert),value, root)
    end
    root
  end

  def delete(value, root)
    if root.data_stored == value
      root = determine_node_children(root)
    else
      traverse_tree(method(:delete), value, root)
    end
    root
  end

  def determine_node_children(root)
    if root.left_child.nil? && root.right_child.nil?
      root = nil
    elsif root.left_child && root.right_child
      smallest_node = find_smallest_child(root.right_child)
      root.data_stored = smallest_node.data_stored
      delete(root.data_stored, root.right_child)
    elsif root.left_child
      root = root.left_child
      root.left_child = nil
    else
      root = root.right_child
      root.right_child = nil
    end
    root
  end

  def find_smallest_child(root)
    if root.left_child.nil?
      root
    else
      root = find_smallest_child(root.left_child)
    end
    root
  end

  def find(value, root)
    if root.data_stored == value
      p root
    else
      traverse_tree(method(:find), value, root)
    end
    root
  end

  def level_order_iterative(root)
    discovered_nodes=[root]
    queued_nodes=[]
    array_of_values=[]

      while discovered_nodes is not empty, push discovered_nodes.each children nodes to queued_nodes
      then push discovered_nodes node.values into array_of_values
      then delete discovered_nodes array
      then copy queued_nodes array into discovered_nodes array

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data_stored}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end


test_array = [1, 3, 5, 6, 7, 8, 9]
test_array.sort!.uniq!
tree = Tree.new(test_array)
root_node = tree.root
tree.pretty_print
tree.insert(4, root_node)
tree.pretty_print
tree.insert(2, root_node)
tree.pretty_print
tree.delete(6, root_node)
tree.pretty_print
tree.find(2, root_node)
tree.level_order_iterative(root_node)
