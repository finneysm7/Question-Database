require_relative 'game'


board = Board.new(false)

piece = Piece.new(board, [2, 1], :w)
piece2 = Piece.new(board, [3, 2], :b)
piece3 = Piece.new(board, [1, 2], :b)
piece4 = Piece.new(board, [3, 4], :b)

board[[2, 1]] = piece
board[[3,2]] = piece2
board[[1, 2]] = piece3
board[[3,4]] = piece4
# kingpiece = Piece.new(board, [2, 3], :w)
# kingpiece.king = true


# p "Before jump: "
# p board[[2,3]]
# p board[[1,2]]
# p board[[0,1]]


# p kingpiece.perform_jump([0,1])

# p "After jump:"
# p board[[2,3]]
# p board[[1,2]]
# p board[[0,1]]

# p "After slide"
# p kingpiece.perform_slide([1,0])

# p board[[0,1]]

# p board[[1,0]]
# # p board.grid

# # p piece.pos
# p "Before jump:"
# p board[[2, 1]] #true
# p board[[3, 2]] #true
# p board[[4, 3]] #false
# p board[[3,4]] #true
# p board[[2, 5]] #false
# puts ""

# # p "Next spots are #{piece.next_spots}"
# # p "Next jumps are #{piece.jumps}"
# puts ""
# piece.perform_moves([[4, 3], [2,5]])
# p "After jump:"
# p board[[2, 1]] #false
# p board[[3, 2]] #false
# p board[[4, 3]] #false
# p board[[3, 4]] #false
# p board[[2, 5]] #true

g = Game.new
g.play


# in jumps: 
 #poss_jumps.select! { |new_pos| on_board?(new_pos) |} not sure if i need this

      # poss_jumps