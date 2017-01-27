require_relative 'ptnode'

class KnightPathFinder

  attr_accessor :start_pos

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
  end

  def valid_pos?(pos)
    pos.all? { |index| index <= 7 && index >= 0 }
  end

  def generate_moves
    row, col = @start_pos
    moves = []
    DELTAS.each do |dx, dy|
      new_pos = [row + dx, col + dy]
      moves << new_pos if valid_pos?(new_pos)
    end
    moves
  end

  def build_children(parent)
    self.generate_moves.map do |move|
      parent.children << PolyTreeNode.new(move)
    end
    parent.children.each { |child| child.parent = parent }
  end

  private

  def show_children(pos)
    vals = []
    build_children(pos).each { |node| vals << node.value }
    vals
  end

end
