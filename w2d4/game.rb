require_relative 'board'
require_relative 'piece'
require 'io/console'
require 'colorize'


class Game
  attr_accessor :board
  def initialize
    @board = Board.new
    @player1 = HumanPlayer.new(@board, :w)
    @player2 = HumanPlayer.new(@board, :b)
  end

  def play
    player = @player1
    self.render
    until @board.over?
      player_color = player.color == :w ? "White" : "Black"
      puts "It is #{player_color}'s turn"
      player.play_turn
      self.render
      player = player == @player1 ? @player2 : @player1
    end
  end

  def render
    board_border = 10
    x, y = 0, 9
    until board_border == 0
      x = 0
      print board_border == 10 ? "#{board_border} " : "#{board_border}  "
      until x > 9
        piece = @board[[x, y]]
        if piece.nil?
          print "   ".colorize(:background => colorize_grid(x, y))
        else
          # icon = [piece.class.to_s, piece.color]
          # print " #{return_icon( icon[0], icon[1] ) } ".colorize(:background => colorize_grid(x, y))
          print piece.color == :w ? " W ".colorize(:background => colorize_grid(x, y)) : " B ".colorize(:background => colorize_grid(x, y))
        end
        x += 1
      end
      print "\n"
      y -= 1
      board_border -= 1
    end
    puts "    a  b  c  d  e  f  g  h  i  j "
  end

  def colorize_grid(x, y)
    (x + y).even? ? :light_red : :light_cyan
  end
end

class HumanPlayer
  attr_accessor :color, :board
  
  def initialize(board, color)
    @board = board
    @color = color
  end
  
  def play_turn
    begin
      puts "Select your move in coordinate-form, e.g. e2, f3, g4"
      input = gets.chomp
      start_pos = parse(input)[0][0]
      move_seq = parse(input)[1]
      if @board[start_pos].nil? || @board[start_pos].color != @color
        raise InvalidInputError 
      end
      @board[start_pos].perform_moves([move_seq])
    rescue InvalidInputError
      puts "Invalid move, try again"
      retry
    rescue InvalidMoveError
      puts "Invalid move! Try again"
      retry
    end
  end

  def parse(input)
    positions = input.split(', ')
    positions.each_index do |i|
      positions[i] = convert_coords(positions[i])
    end
    raise InvalidInputError if positions.size < 2
    start_pos = positions.shift

    move_seq = positions

    return [[start_pos], move_seq]
  end

  def convert_coords(coords)
    index_arr = (:a..:j).to_a  
    x = index_arr.index(coords[0].to_sym)
    y = coords[1].to_i - 1
    [x, y]
  end


  #Time to start tying to add cursor ability! This might take a while..
  def get_input
    begin
      user_input = STDIN.getch
      unless ['a', 's', 'd', 'w', ' '].include?(user_input)
        raise InvalidInputError.new('Please use the asdw keys to move')
      end
    rescue InvalidInputError
      retry
    end
    user_input
  end

  def cursor_input
    case user_input
    when 'w' then :up
    when 's' then :down
    when 'a' then :left
    when 'd' then :right
    else raise InvalidInputError.new('Please use the asdw keys to move')
    end
  end

  def cursor_diff(dir)
    case dir
    when :up then [0, 1]
    when :down then [0, -1]
    when :left then [-1, 0]
    when :right then [1, 0]
    end
  end

  def move_cursor(diff)
    dx, dy = diff
    new_cursor_pos = [board.cursor_pos[0] + dx, board.cursor_pos[1] + dy]
    board.cursor_pos = new_cursor_pos #unless off board

  end
end
