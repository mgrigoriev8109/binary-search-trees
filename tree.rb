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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data_stored}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  def delete(value, root)
    if root.data_stored == value
      root = base_case(root)
    elsif value < root.data_stored 
      root.left_child = delete(value, root.left_child)
    else
      root.right_child = delete(value, root.right_child)
    end
    root
  end

  def base_case(root)
    if root.left_child.nil? && root.right_child.nil?
      root = nil
    elsif root.left_child && root.right_child
      smallest_node = find_smallest(root.right_child)
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

  def find_smallest(root)
    if root.left_child.nil?
      root
    else
      root = find_smallest(root.left_child)
    end
    root
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
