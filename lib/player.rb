# frozen_string_literal: true

# class for each player
class Player
  attr_reader :symbol, :name

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  # send in the board object to check if column is full
  def choose_column(board)
    loop do
      puts "\n"
      puts "#{name}, please enter a column number"
      column = gets.to_i - 1
      return column if column.between?(0, 6) && !board.column_full?(column)

      puts 'Please select a column between 1-7'
    end
  end

  # send messages to board object to check for player wins
  def win?(board)
    board.row_win?(symbol) ||
      board.column_win?(symbol) ||
      board.diagonal_win?(symbol)
  end
end
