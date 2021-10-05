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

  def traverse_tree(callback_method, value, root)
    if value < root.data_stored
      root.left_child = callback_method.call(value, root.left_child)
    else
      root.right_child = callback_method.call(value, root.right_child)
    end
    root
  end

  def find(value, root)
    if root.data_stored == value
      root
    elsif value < root.data_stored
      root = find(value, root.left_child)
    else
      root = find(value, root.right_child)
    end
    root
  end

  def level_order_iterative(root)
    discovered_nodes=[root]
    queued_nodes=[]
    array_of_values=[]
    until discovered_nodes.empty? 
      iterate_through_arrays(discovered_nodes, queued_nodes, array_of_values)
      discovered_nodes = []
      discovered_nodes = queued_nodes
      queued_nodes = []
    end
    array_of_values
  end

  def level_order_recursive(root, discovered_nodes = [root], queued_nodes = [], array_of_values = [])
    if discovered_nodes.empty?
      array_of_values
    else
      iterate_through_arrays(discovered_nodes, queued_nodes, array_of_values)
      discovered_nodes = queued_nodes
      queued_nodes = []
      level_order_recursive(root, discovered_nodes, queued_nodes, array_of_values)
    end
    array_of_values
  end

  def iterate_through_arrays(discovered_nodes, queued_nodes, array_of_values)
    discovered_nodes.each do |node|
      unless node.nil? 
        queued_nodes.push(node.left_child, node.right_child)
        array_of_values.push(node.data_stored)
      end
    end
  end

  def inorder_depth_traversal(root, array_of_values =[])
    if root.nil?
      array_of_values
    else
      inorder_depth_traversal(root.left_child, array_of_values)
      array_of_values.push(root.data_stored)
      inorder_depth_traversal(root.right_child, array_of_values)
    end
    array_of_values
  end

  def pre_order_depth_traversal(root, array_of_values = [])
    if root.nil?
      array_of_values
    else
      array_of_values.push(root.data_stored)
      inorder_depth_traversal(root.left_child, array_of_values)
      inorder_depth_traversal(root.right_child, array_of_values)
    end
    array_of_values
  end

  def post_order_depth_traversal(root, array_of_values = [])
    if root.nil?
      array_of_values
    else
      inorder_depth_traversal(root.left_child, array_of_values)
      inorder_depth_traversal(root.right_child, array_of_values)
      array_of_values.push(root.data_stored)
    end
    array_of_values
  end

  def height(root, height = 0, left_tree_height = 0, right_tree_height = 0)
    if root.nil?
      height -= 1
    else
      left_tree_height = height(root.left_child, height, left_tree_height, right_tree_height)
      right_tree_height = height(root.right_child, height, left_tree_height, right_tree_height)
      if left_tree_height > right_tree_height
        height = left_tree_height + 1
      else
        height = right_tree_height + 1
      end
    end
    height
  end

  def depth(root, depth_root, depth = 0)
    if root.data_stored == depth_root.data_stored
      depth
    elsif depth_root.data_stored < root.data_stored
      depth += 1
      depth = depth(root.left_child, depth_root, depth)
    else
      depth += 1
      depth = depth(root.right_child, depth_root, depth)
    end
    depth
  end

  def balanced?(root, balanced = true)
    if root.nil?
      true
    elsif (height(root.left_child) - height(root.right_child)) > 1
      balanced = false
    elsif (height(root.left_child) - height(root.right_child)) < 0
      balanced = false
    else
      balanced?(root.left_child)
      balanced?(root.right_child)
    end
    balanced
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data_stored}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

end


test_array = [1, 3, 5, 6, 7, 8, 9, 11, 23, 19]
test_array.sort!.uniq!
tree = Tree.new(test_array)
root_node = tree.root
tree.pretty_print
puts tree.balanced?(root_node)
tree.insert(4, root_node)
tree.insert(2, root_node)
tree.insert(10, root_node)
tree.insert(14, root_node)
tree.insert(15, root_node)
tree.insert(17, root_node)
tree.insert(18, root_node)
tree.insert(21, root_node)
tree.insert(25, root_node)
tree.pretty_print
iterative_level_order_array = tree.level_order_iterative(root_node)
p iterative_level_order_array
p tree.level_order_recursive(root_node)
p tree.inorder_depth_traversal(root_node)
p tree.pre_order_depth_traversal(root_node)
p tree.post_order_depth_traversal(root_node)
found_node = tree.find(15, root_node)
#p "Height test for node with value 15"
#height = tree.height(found_node)
#p height
#p "Depth test for node with value 15"
#depth = tree.depth(root_node, found_node)
#p depth
puts tree.balanced?(root_node)