# frozen_string_literal: true

# class for each player
class Player
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def choose_column
    loop do
      puts 'Please enter a column number'
      column = gets.to_i - 1
      return column if column.between?(0, 6)

      puts 'Please select a column between 1-7'
    end
  end

  def win?(board)
    board.row_win?(symbol) ||
      board.column_win?(symbol) ||
      board.diagonal_win?(symbol)
  end
end
