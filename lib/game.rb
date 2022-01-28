# frozen_string_literal: true

require_relative './board'
require_relative './player'

# class for the game logic
class Game
  attr_reader :board
  attr_accessor :player_one, :player_two

  def initialize
    @board = Board.new
    @player_one = nil
    @player_two = nil
  end

  def assign_players
    puts 'Player one, what is your name?'
    @player_one = Player.new(gets.chomp, 'X')

    puts 'Player two, what is your name?'
    @player_two = Player.new(gets.chomp, 'O')
  end
end
