class Node
    
  attr_accessor :data_stored, :left_child, :right_child

  def initialize(data_stored = nil, left_child = nil, right_child = nil)
    @data_stored = data_stored
    @left_child = left_child
    @right_child = right_child
  end

end