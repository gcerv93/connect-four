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
end

# rubocop: enable Metrics/BlockLength
