require_relative "ptn.rb"
require "byebug"
DELTAS = [
  [1,2],
  [2,1],
  [1,-2],
  [2,-1],
  [-1,2],
  [-2,1],
  [-1,-2],
  [-2,-1]
].freeze

class KnightPathFinder
  attr_accessor :root_node, :considered_positions

  def initialize(start_location)
    @root_node = PolyTreeNode.new(start_location)
    @considered_positions = [start_location]
    build_move_tree
  end

  def new_move_positions(pos)
    arr = []

    DELTAS.each do |delta|
      new_pos = [pos.first+delta.first,pos.last+delta.last]

      arr << new_pos if is_legal?(new_pos) && !self.considered_positions.include?(new_pos)
    end

    self.considered_positions += arr
    arr
  end

  def is_legal?(arr)
    return false unless (0..7).include?(arr.first)
    return false unless (0..7).include?(arr.last)

    true
  end

  def build_move_tree
    queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      new_move_positions(current_node.position).each do |position|
        # debugger
        node = PolyTreeNode.new(position)
        current_node.add_child(node)
        queue << node
      end
    end
  end
end


