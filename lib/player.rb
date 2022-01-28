# frozen_string_literal: true

# class for each player
class Player
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
end