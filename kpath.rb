require_relative 'ptnode'
require 'byebug'

class KnightPathFinder

  attr_accessor :start_pos, :current_pos

  DELTAS = [
    [2, -1],
    [2, 1],
    [-2, -1],
    [-2, 1],
    [1, -2],
    [1, 2],
    [-1, -2],
    [-1, 2]
  ]
  def initialize(start_pos)
    @start_pos = start_pos
    @root = PolyTreeNode.new(start_pos)
    @seen_places = []
    @current_pos = @start_pos
  end

  def valid_pos?(pos)
    pos.all? { |index| index <= 7 && index >= 0 }
  end

  def generate_moves
    row, col = @current_pos
    moves = []
    DELTAS.each do |dx, dy|
      new_pos = [row + dx, col + dy]
      moves << new_pos if valid_pos?(new_pos)
    end
    moves
  end

  def build_children(parent)
    self.generate_moves.map do |move|
      unless @seen_places.include?(move)
        parent.children << PolyTreeNode.new(move)
      end
    end
    parent.children.each { |child| child.parent = parent }
  end

  def find_path(final_pos)
    queue = [@root]
    until queue.empty?
      current_node = queue.shift
      @current_pos = current_node.value
      @seen_places << current_node.value
      break if current_node.value == final_pos
      queue += build_children(current_node)
    end
    trace_back_path(current_node).reverse
  end

  def trace_back_path(node)
    path = []
    until node == nil
      path << node.value
      node = node.parent
    end
    path
  end




  private

  def show_children(pos)
    vals = []
    build_children(pos).each { |node| vals << node.value }
    vals
  end

end
