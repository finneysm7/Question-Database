require 'debugger'
require 'colorize'

class InvalidMoveError < ArgumentError
end
class InvalidInputError < ArgumentError
end

class Piece
  attr_accessor :king, :pos, :color, :board

  def initialize(board, pos, color)
    @board, @pos, @color = board, pos, color
    # @board = board, @pos = pos, @color = color
    # debugger
    @king = false
  end

  def direction
    if @king == true
      return [-1, 1]
    else
      @color == :w ? [1] : [-1]
    end
  end

  def slides
    poss_slides = next_spots

    poss_slides.select! { |new_pos| @board[new_pos].nil? }

    poss_slides
  end

  def next_spots
    poss_slides = []
    curr_x = @pos[0]
    curr_y = @pos[1]
    directions = self.direction
    directions.each do |dir|
      poss_slides << [curr_x - 1, curr_y + dir] << [curr_x + 1, curr_y + dir]
    end
    poss_slides.select! { |new_pos| on_board?(new_pos) }

    poss_slides
  end

  def on_board?(position)
    position[0].between?(0, 9) && position[1].between?(0, 9)
  end

  def perform_slide(new_pos)
    return false unless self.slides.include?(new_pos)

    @board[new_pos] = self
    @board[@pos] = nil
    @pos = new_pos

    maybe_promote
    true
  end

  def jumps
   opp_color = @color == :w ? :b : :w
   near_enemies = next_spots
   poss_jumps = []   
   near_enemies.select! do |new_pos| 
    !@board[new_pos].nil? && @board[new_pos].color == opp_color 
    end #arr of enemies nearby

    near_enemies.each do |new_pos|
      dx = new_pos[0] < @pos[0] ? -2 : 2
      dy = new_pos[1] < @pos[1] ? -2 : 2
      poss_jump = [@pos[0] + dx, @pos[1] + dy ]
      poss_jumps << poss_jump if @board[poss_jump].nil?
    end
    poss_jumps
  end

  def perform_jump(new_pos)
    return false unless self.jumps.include?(new_pos)
    x_dir = new_pos[0] < @pos[0] ? -1 : 1
    y_dir = new_pos[1] < @pos[1] ? -1 : 1
    enemy_loc = [@pos[0] + x_dir, @pos[1] + y_dir]

    @board[enemy_loc] = nil
    @board[new_pos] = self
    @board[@pos] = nil
    @pos = new_pos
    maybe_promote

    true
  end

  def perform_moves!(move_sequence)
    num_moves = move_sequence.length
    # debugger
    valid = true
    if num_moves == 1
      valid = self.perform_slide(move_sequence[0])
      if !valid
        valid = self.perform_jump(move_sequence[0])
      end
      raise InvalidMoveError unless valid
    else
      num_moves.times do 
        valid = self.perform_jump(move_sequence.shift)
        raise InvalidMoveError unless valid
      end
    end

    valid
  end

  def valid_move_seq?(move_sequence)
    # move_sequence = move_sequence[0] #flatten?
    duped = @board.deep_dup
    position = self.pos
    begin
      duped[position].perform_moves!(move_sequence)
    rescue InvalidMoveError
      return false
    else
      return true
    end
  end

  def maybe_promote
    end_row = @color == :w ? 9 : 0
    @king = true if @pos[1] == end_row
  end

  def perform_moves(move_sequence)

    move_sequence = move_sequence[0]
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence.dup)
    else
      raise InvalidMoveError
    end    

    true
  end

  def inspect
    "#{self.pos} #{self.color}"
  end
end


