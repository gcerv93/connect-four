# frozen_string_literal: true

# class for the game board
class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, '') }
  end

  def display_board
    board.each do |row|
      row.each_with_index do |cell, i|
        row[i] = ' ' if cell.empty?
      end
      puts "| #{row[0]} | #{row[1]} | #{row[2]} | #{row[3]} | #{row[4]} | #{row[5]} | #{row[6]} |"
    end
    puts '-----------------------------'
    puts '| 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
    reconfigure_board
  end

  def update_board(column, symbol)
    board.each_with_index do |row, idx|
      if row[column].empty? && idx == 5
        assign_symbol(idx, column, symbol)
      elsif !row[column].empty? && board[idx - 1][column].empty?
        assign_symbol(idx - 1, column, symbol)
      end
    end
  end

  private

  def reconfigure_board
    board.each do |row|
      row.each_with_index do |cell, i|
        row[i] = '' if cell == ' '
      end
    end
  end

  def assign_symbol(row, column, symbol)
    board[row][column] = symbol
  end
end
