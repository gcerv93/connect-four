# frozen_string_literal: true

# class for the game board
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, '') }
  end

  def update_board(column, symbol)
    board.each_with_index do |row, idx|
      if row[column].empty? && idx == 5
        row[column] = symbol
      elsif !row[column].empty? && board[idx - 1][column].empty?
        board[idx - 1][column] = symbol
      end
    end
  end
end
