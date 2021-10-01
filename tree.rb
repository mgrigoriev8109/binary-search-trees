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
    if root.data_stored == value && root.left_child.nil? && root.right_child.nil?
      root = nil
    elsif root.data_stored == value && root.left_child.nil? && root.right_child.nil?
      #base case if both exist
    elsif root.data_stored == value && root.left_child.nil? && root.right_child.nil?
      #base case if only one exists
    elsif value < root.data_stored 
      root.left_child = delete(value, root.left_child)
    else
      root.right_child = delete(value, root.right_child)
    end
    root
  end

  # as some point make a def traverse(value, root) method using a proc object
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
tree.delete(4, root_node)
tree.pretty_print
