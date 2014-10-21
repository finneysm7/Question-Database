require_relative 'piece'

class Board

  attr_accessor :grid, :cursor_pos

  def initialize(fill_board = true)
    @grid = Array.new(10) { Array.new(10) }
    set_pieces if fill_board
  end

  #TODO: Refactor
  def set_pieces
    x_inc = 0
    4.times do |y|
      (0..8).step(2) do |x|
        x_inc = x + 1 if y.odd?
        x_inc = x if y.even?
        @grid[x_inc][y] = Piece.new(self, [x_inc, y], :w)
      end
    end

    9.downto(6) do |y|
      (0..8).step(2) do |x|
        x_inc = x if y.even?
        x_inc = x + 1 if y.odd?
        @grid[x_inc][y] = Piece.new(self, [x_inc, y], :b)
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    @grid[x][y] = piece
  end

  def pieces
    @grid.flatten.compact
  end

  def pieces_of_color(color)
    pieces.select { |p| p.color == color }
  end

  def deep_dup
    duped = Board.new(false)
    pieces.each do |piece|
      duped[piece.pos] = Piece.new(duped, piece.pos, piece.color)
    end

    duped
  end

  def over?
    pieces_of_color(:w) == 0 || pieces_of_color(:b) == 0
  end
end
