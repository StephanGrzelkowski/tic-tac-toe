class GameState 
	attr_reader :board_array 


	def initialize()
		@board_array = [["1","2","3"],["4","5", "6"],["7","8","9"]]
	end

	

	def display_board()

		puts "\n
			  #{@board_array[0][0]}  #{@board_array[0][1]}  #{@board_array[0][2]}\n 
			  #{@board_array[1][0]}  #{@board_array[1][1]}  #{@board_array[1][2]}\n 
			  #{@board_array[2][0]}  #{@board_array[2][1]}  #{@board_array[2][2]}\n" 
	end

	def update_board(board_array)

		@board_array = board_array
		display_board()
	end

	def player_input(turn)
		turn = 2 if turn === 0
		p "It's Player #{turn}'s turn. Where do you set your mark (1 - 9)?"
		postition = gets().to_i
		signW = "X" if turn === 1 
		signW = "O" if turn === 2

		case postition 
		when 1 then @board_array[0][0] = signW
		when 2 then @board_array[0][1] = signW
		when 3 then @board_array[0][2] = signW
		when 4 then @board_array[1][0] = signW 
		when 5 then @board_array[1][1] = signW 
		when 6 then @board_array[1][2] = signW 
		when 7 then @board_array[2][0] = signW 
		when 8 then @board_array[2][1] = signW 
		when 9 then @board_array[2][2] = signW 
		end
	end

	def get_diagonals()
		arr = [] 
		arr[0] = 3.times.collect do |i|
			@board_array[i][i]
		end
		arr[1] = 3.times.collect do |i|
			@board_array[i][2-i]
		end
		return arr

	end	

	def get_columns()

		3.times.collect do |i|
			3.times.collect do |j|
				@board_array[j][i]
			end
		end
	end

	def check_win(pairs)
		if pairs[0].is_a?(Array)
			pairs.each do |arr|
				if (arr.uniq.length === 1 && (arr.include?("O") || arr.include?("X")))
					declare_winner(arr[0])
					return true
				end
			end	
		else 
			if (pairs.uniq.length === 1 && (pairs.include?("O") || pairs.include?("X")))
				declare_winner(pairs[0])
				return true
			end
		end
		false	
	end

	def declare_winner(signW)
		if signW === "O"
			p "Player 2 won!" 
		else
			p "Player 1 won!"
		end

	end

end

game = GameState.new

winner = false
turn = 1
while !winner
	game.display_board

	game.player_input(turn%2)

	game.display_board
	winner = game.check_win(game.board_array)

	if !winner
		arr = game.get_columns
		winner = game.check_win(arr) 
	end

	if !winner	
		arr = game.get_diagonals
		winner = game.check_win(arr)
	end

	turn += 1
end



