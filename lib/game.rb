# frozen_string_literal: true

require_relative './board'
require_relative './player'

# class for the game logic
class Game
  attr_reader :board
  attr_accessor :player_one, :player_two, :current_player, :turns

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
    @turns = 0
  end

  def assign_players
    puts 'Player one, what is your name?'
    @player_one = Player.new(gets.chomp, "\u263a")
    puts "\n"
    puts 'Player two, what is your name?'
    @player_two = Player.new(gets.chomp, "\u263b")
    puts "\n"
    @current_player = @player_one
  end

  def game_loop
    while turns <= 42
      board.update_board(current_player.choose_column, current_player.symbol)
      board.display_board
      if current_player.win?(board)
        congratulate_winner
        break
      end
      change_turns
    end
    new_game?
  end

  def start_game
    puts "Welcome to Connect Four!\n\n"
    assign_players
    board.display_board
    game_loop
  end

  private

  def change_current_player
    @current_player = @current_player == player_one ? player_two : player_one
  end

  def change_turns
    @turns += 1
    change_current_player
  end

  def congratulate_winner
    puts "\n"
    puts "Congrats #{current_player.name}, you win!"
  end

  def new_game?
    puts 'Press Y if you want to play a new game, press any other key to quit'
    answer = gets.chomp.downcase
    answer == 'y' ? Game.new.start_game : (puts 'GoodBye')
  end
end
