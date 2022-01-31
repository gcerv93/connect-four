# frozen_string_literal: true

require_relative '../lib/board'

# rubocop: disable Metrics/BlockLength

describe Board do
  subject(:board) { described_class.new }

  describe '#update_board' do
    context "when there's no other chip on that column" do
      it 'places chip on the bottom row' do
        column = 3
        bottom_row = 5
        board.update_board(column, 'x')
        expect(board.board[bottom_row][column]).to_not be_empty
      end

      it 'does not place chip in any other row' do
        column = 3
        row = 4
        board.update_board(column, 'x')
        expect(board.board[row][column]).to be_empty
      end
    end

    context "when there's already a chip in that column" do
      it 'does not overwrite that chip' do
        board.board[5][3] = 'x'
        column = 3
        symbol = 'o'
        board.update_board(column, symbol)
        expect(board.board[5][3]).to_not eq(symbol)
      end

      it 'places chip on above row' do
        board.board[5][3] = 'x'
        column = 3
        symbol = 'o'
        above_row = 4
        board.update_board(column, symbol)
        expect(board.board[above_row][column]).to eq(symbol)
      end
    end

    context 'when column is full' do
      it 'does nothing' do
        column = 3
        symbol = 'x'
        board.board[5][column] = 'o'
        board.board[4][column] = 'o'
        board.board[3][column] = 'o'
        board.board[2][column] = 'o'
        board.board[1][column] = 'o'
        board.board[0][column] = 'o'
        board.update_board(column, symbol)
        expect(board.board[5][column]).to_not eq(symbol)
      end
    end
  end

  describe '#column_full?' do
    it 'returns true if column is full' do
      column = 3
      board.board[5][column] = 'o'
      board.board[4][column] = 'o'
      board.board[3][column] = 'o'
      board.board[2][column] = 'o'
      board.board[1][column] = 'o'
      board.board[0][column] = 'o'
      result = board.column_full?(column)
      expect(result).to eq(true)
    end

    it 'returns false if column is not full' do
      column = 3
      board.board[5][column] = 'o'
      board.board[4][column] = 'o'
      board.board[3][column] = 'o'
      board.board[2][column] = 'o'
      board.board[1][column] = 'o'
      result = board.column_full?(column)
      expect(result).to eq(false)
    end
  end

  describe '#row_win?' do
    context 'when theres a win on a row' do
      it 'returns true if starting from index 0' do
        row = 5
        symbol = 'x'
        board.board[row][0] = symbol
        board.board[row][1] = symbol
        board.board[row][2] = symbol
        board.board[row][3] = symbol
        result = board.row_win?(symbol)
        expect(result).to eq(true)
      end

      it 'returns true if starting from index 1' do
        row = 5
        symbol = 'x'
        board.board[row][1] = symbol
        board.board[row][2] = symbol
        board.board[row][3] = symbol
        board.board[row][4] = symbol
        result = board.row_win?(symbol)
        expect(result).to eq(true)
      end
    end

    context "when there's not a win on a row" do
      it 'returns false when empty' do
        symbol = 'x'
        result = board.row_win?(symbol)
        expect(result).to eq(false)
      end

      it 'returns false when only 3 in a row' do
        row = 0
        symbol = 'x'
        board.board[row][0] = symbol
        board.board[row][1] = symbol
        board.board[row][2] = symbol
        result = board.row_win?(symbol)
        expect(result).to eq(false)
      end

      it 'returns false when symbols are interspersed' do
        row = 0
        symbol_x = 'x'
        symbol_y = 'y'
        board.board[row][0] = symbol_x
        board.board[row][1] = symbol_y
        board.board[row][2] = symbol_x
        board.board[row][3] = symbol_y
        board.board[row][4] = symbol_x
        board.board[row][5] = symbol_y
        result = board.row_win?(symbol_x)
        expect(result).to eq(false)
      end
    end
  end

  describe '#column_win?' do
    context "when there's a column win" do
      it 'returns true starting from bottom row' do
        symbol = 'x'
        column = 0
        board.board[5][column] = symbol
        board.board[4][column] = symbol
        board.board[3][column] = symbol
        board.board[2][column] = symbol
        result = board.column_win?(symbol)
        expect(result).to eq(true)
      end

      it 'returns true in middle of column' do
        symbol = 'x'
        column = 3
        board.board[3][column] = symbol
        board.board[2][column] = symbol
        board.board[1][column] = symbol
        board.board[0][column] = symbol
        result = board.column_win?(symbol)
        expect(result).to eq(true)
      end
    end

    context "when there's no column win" do
      it 'returns false when empty' do
        symbol = 'x'
        result = board.column_win?(symbol)
        expect(result).to eq(false)
      end

      it 'returns false when only 3 in a column' do
        symbol = 'x'
        column = 5
        board.board[5][column] = symbol
        board.board[4][column] = symbol
        board.board[3][column] = symbol
        result = board.column_win?(symbol)
        expect(result).to eq(false)
      end

      it 'returns false when symbols are interspersed' do
        symbol_x = 'x'
        symbol_o = 'o'
        column = 4
        board.board[5][column] = symbol_x
        board.board[4][column] = symbol_o
        board.board[3][column] = symbol_x
        board.board[2][column] = symbol_o
        board.board[1][column] = symbol_x
        board.board[0][column] = symbol_o
        result = board.column_win?(symbol_o)
        expect(result).to eq(false)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
