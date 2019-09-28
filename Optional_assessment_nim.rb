class Nim
  def initialize(players)
    #Initialize what level of game player wants (easy- 1, medium- 2, hard- 3)
    @difficulty = ()
    @player1 = players[0]
    @player2 = players[1]
    @players = players
    @easy = []
    @medium = []
    @hard = []
    @game_end = false
    @number_piles = []
    @game_piles = []
    @is_game_over = ()
    @current_player = ""
    @last_player = ""
    @player_moves = {}
    @score_board = {}
    @score_board[@player1] = 0
    @score_board[@player2] = 0
    @done_playing = false
    @game_count = 0
  end

  def game_count
    @game_count
  end

  def done_playing
    @done_playing
  end

  def done_playing=(done_playing)
    @done_playing = done_playing
  end

  def score_board
    @score_board
  end

  def current_player
    @current_player
  end

  def last_player
    @last_player
  end

  def difficulty
    @difficulty
  end

  def player1
    @player1
  end

  def player2
    @player2
  end

  def players
    @players
  end

  def easy
    @easy
  end

  def medium
    @medium
  end

  def hard
    @hard
  end

  def number_piles
    @number_piles
  end

  def is_game_over
    @is_game_over
  end

  def player_moves
    @player_moves
  end

  def switch()
    temp = @last_player
    @last_player = @current_player
    @current_player = temp
    puts "#{@current_player} it's your move"
  end

  def print_game_moves
    moves = ""

    moves << "#{@player1}'s' moves\n"
    @player_moves["#{@player1} Game #{@game_count}"].each do |move|
      moves << "Row #{move[0]} -  #{move[1]} sticks \n"
    end

    moves << "\n"
    moves << "#{@player2}'s' moves\n"
    @player_moves["#{@player2} Game #{@game_count}"].each do |move|
      moves << "Row #{move[0]} - #{move[1]} sticks \n"
    end

    return moves
  end

  def print_score
    score = ""
    @score_board.each_key do |p_name|
      score << "#{p_name}'s score - #{@score_board[p_name]} \n"
    end

    return score
  end

  def start()
    m = 0
    @game_count += 1
    puts "GET READY TO PLAY!"
    puts "1- Easy: 2 piles"
    puts "2- Medium: 3 piles"
    puts "3- Hard: 7 piles"
    print "Select game difficulty (1, 2, or 3): "
    @difficulty = gets.chomp.to_i
    @number_piles = 0
    while @difficulty != 1 && @difficulty != 2 && @difficulty != 3
      print "Invalid Selection! Select between 1, 2, and 3:"
      @difficulty = gets.chomp.to_i
    end
    @game_piles = []

    if @difficulty == 1
      @number_piles = 2
    elsif @difficulty == 2
      @number_piles = 3
    elsif @difficulty == 3
      @number_piles = 7
    else puts "Please enter a valid input."     end

    for i in 1..@number_piles
      @game_piles.push(rand(1..7))
    end

    @current_player = players.sample
    if (@current_player == @player1)
      @last_player = @player2
    else
      @last_player = @player1
    end

    @player_moves["#{@player1} Game #{@game_count}"] = []
    @player_moves["#{@player2} Game #{@game_count}"] = []
  end

  def print_stars
    for i in 1..@game_piles.count
      print i.to_s << " - "
      puts "\u273D " * @game_piles[i - 1]
    end
  end

  def move()
    print_stars
    switch()
    puts
    print "Select your row(1-#{@number_piles}): "
    row = gets.chomp.to_i
    while row > @number_piles || row == 0 || @game_piles[row - 1] == 0
      if @game_piles[row - 1] == 0
        print "There aren't any more sticks in the row. Select a different row: "
        row = gets.chomp.to_i
      else
        print "Invalid row. Select valid row: "
        row = gets.chomp.to_i
      end
    end

    sticks = @game_piles[row - 1]
    if sticks == 1
      print "Select the number of sticks (1): "
    else
      print "Select number of sticks (1-#{sticks}): "
    end
    num_dots = gets.chomp.to_i
    while num_dots > sticks || num_dots < 1
      print "Invalid number of sticks. Select a valid number of sticks (1-#{sticks}): "
      num_dots = gets.chomp.to_i
    end
    sticks = sticks - num_dots
    @game_piles[row - 1] = sticks
    @player_moves["#{@current_player} Game #{@game_count}"].push([row, num_dots])
    puts
  end

  def is_game_over
    sum = 0
    @game_piles.each do |num|
      sum += num
    end
    if sum == 0
      @game_end = true
      @score_board[@last_player] += 1
    end
  end
end

players = []

#actually play a GAME
puts "Who is Player 1"
player1 = gets.chomp
players.push(player1)
puts "Who is Player 2"
player2 = gets.chomp
players.push(player2)

nim = Nim.new(players)
nim.start()

until nim.done_playing
  until nim.is_game_over
    nim.move
  end

  puts "#{nim.last_player} is the winner!"
  puts nim.print_game_moves()
  puts "Would you like to play again?"

  play_again = gets.chomp
  if play_again == "yes"
    nim.start()
  else
    nim.done_playing = true
  end
end

puts nim.print_score
