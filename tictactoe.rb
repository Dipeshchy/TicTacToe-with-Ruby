class Tictactoe
    $boards = [[" "," "," "],[" "," "," "],[" "," "," "]]
    $turn = 1

    # Main Method runner
    def initialize
        show_board
        user_turn
    end

    # show board
    def show_board
        $boards.each do |board|
            board.each do |b|
                print b 
                print " | "
            end
            puts ""
            puts "-----------"
        end
    end

    # Take input from user for the position of X and O
    def user_input(player)
        unless is_game_finished
            puts "Its #{player}'s turn.Enter your input position ==>"
            pos = gets.chomp.to_i
            return pos
        else
            puts "Game finished.Draw."
        end
    end

    # User TURN . It checks for whose turn and processes the turn
    def user_turn
        player = $turn % 2 == 0 ? "X" : "O"
            unless is_game_finished
                if !check_winner
                        if (1..9).include?(pos=user_input(player))
                            if check_if_position_is_empty(pos)
                                row,col = boardPostion(pos)
                                $boards[row][col] = player
                                show_board
                                $turn+=1
                                user_turn
                            else
                                puts "This field is already filled"
                                user_turn
                            end
                        else
                            puts "Enter a valid position between 1 and 9."
                            show_board
                            user_turn
                        end
                else
                    winner = $turn % 2 == 0 ? "O" : "X"
                    puts "Congratulations.Winner is #{winner}"
                end
            else
                if check_winner
                    winner = $turn % 2 == 0 ? "O" : "X"
                    puts "Congratulations.Winner is #{winner}"
                else
                    puts "Game Finished.Draw."
                end
            end
    end

    # Locate the position of user input
    def boardPostion(pos)
        if(1..3).include?pos
            row = 0
            col = (pos %3) - 1
        elsif (4..6).include?pos
            row = 1
            col = pos%3 == 0 ?  2 : ((pos%3) - 1)
        else
            row = 2
            col = pos%3 == 0 ?  2 : ((pos%3) - 1)
        end
        return row,col
    end

    # Check if the position entered by user is empty or not ?
    def check_if_position_is_empty(pos)
        row,col = boardPostion(pos)
        return $boards[row][col] == " " ? true : false
    end

    # Check if the game is finished if all the positions or board is filled or not ?
    def is_game_finished
        $boards.flatten.include?(" ") ? false : true
    end

    # Check winner. Fields are equal if the length of unique items in array is equal to 1
    def check_winner
        flag = 0
        for i in (0..2)
            if !$boards[i].include?(" ") && $boards[i].uniq.length == 1
                flag += 1
            end

            if !$boards.transpose[i].include?(" ") && $boards.transpose[i].uniq.length == 1
                flag += 1
            end  
            
            if !$boards[i].include?(" ") && [$boards[0][0],$boards[1][1],$boards[2][2]].uniq.length == 1
                flag += 1
            end

            if !$boards[i].include?(" ") && [$boards[0][2],$boards[1][1],$boards[2][0]].uniq.length == 1
                flag += 1
            end
        end
        return flag > 0 ? true : false
    end

end

# Instantiating the class
Tictactoe.new