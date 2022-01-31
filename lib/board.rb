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

  def column_full?(column)
    i = 0
    while i < 6
      return false if board[i][column].empty?

      i += 1
    end
    true
  end

  def row_win?(symbol, board = @board)
    check = []
    board.each do |row|
      row.each_with_index do |cell, idx|
        check << row[idx..idx + 3] if cell == symbol && idx < 3
        check.flatten.all?(symbol) ? (return true) : next unless check.empty?
      end
      check.clear
    end
    false
  end

  # reverse the board before transposing, otherwise columns will be
  def column_win?(symbol)
    row_win?(symbol, board.reverse.transpose)
  end

  def diagonal_win?(symbol)
    board.reverse.each_with_index do |row, idx|
      row.each_with_index do |_cell, i|
        return true if up_left_diag(idx, i, symbol)

        return true if left_diag(idx, i, symbol)

        return true if right_diag(idx, i, symbol)
      end
      break if idx >= 2
    end
    false
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

  def left_diag(row, col, symbol)
    board = @board.reverse
    check = [board[row][col]]
    3.times do
      row -= 1
      col += 1
      check << board[row][col] unless row.negative?
    end
    return check.all?(symbol) if check.length == 4
  end

  def up_left_diag(row, col, symbol)
    board = @board.reverse
    check = [board[row][col]]
    3.times do
      row += 1
      col -= 1
      check << board[row][col] unless row.negative? || col.negative?
    end
    return check.all?(symbol) if check.length == 4
  end

  def right_diag(row, col, symbol)
    board = @board.reverse
    check = [board[row][col]]
    3.times do
      row += 1
      col += 1
      check << board[row][col] unless row > 5 || col > 6
    end
    return check.all?(symbol) if check.length == 4
  end
end
