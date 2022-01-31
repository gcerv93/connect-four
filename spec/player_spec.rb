# frozen_string_literal: true

require_relative '../lib/player'

# rubocop: disable Metrics/BlockLength

describe Player do
  subject(:player) { described_class.new('dude', 'X') }

  describe '#choose_column' do
    before do
      allow(player).to receive(:gets).and_return('5')
      allow(player).to receive(:puts)
    end

    it 'asks for the player column' do
      expect(player).to receive(:gets)
      player.choose_column
    end

    context 'when the column number is invalid' do
      it 'only accepts column numbers between 1 and 7' do
        allow(player).to receive(:gets).and_return('8', '9', '10', '5')
        expect(player).to receive(:gets).at_least(3).times
        player.choose_column
      end

      it 'does not return invalid number' do
        allow(player).to receive(:gets).and_return('-1', '-2', '3')
        expect(player.choose_column).to_not eq(-1)
      end

      it 'calls gets until number is valid' do
        allow(player).to receive(:gets).and_return('10', '8', '9', '3')
        expect(player).to receive(:gets).exactly(4).times
        player.choose_column
      end
    end
  end

  describe '#win?' do
    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:row_win?)
      allow(board).to receive(:column_win?)
      allow(board).to receive(:diagonal_win?)
    end

    context 'sends messages to Board class' do
      it 'sends row_win? message' do
        expect(board).to receive(:row_win?).at_least(1).times
        player.win?(board)
      end

      it 'sends column_win? message' do
        expect(board).to receive(:column_win?).at_least(1).times
        player.win?(board)
      end

      it 'sends diagonal_win? message' do
        expect(board).to receive(:diagonal_win?).at_least(1).times
        player.win?(board)
      end
    end

    context 'when theres a win for player' do
      it 'returns true for a row win' do
        allow(board).to receive(:row_win?).and_return(true)
        result = player.win?(board)
        expect(result).to eq(true)
      end

      it 'returns true for a column win' do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(true)
        result = player.win?(board)
        expect(result).to eq(true)
      end

      it 'returns true for a diagonal win' do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(false)
        allow(board).to receive(:diagonal_win?).and_return(true)
        result = player.win?(board)
        expect(result).to eq(true)
      end
    end

    context "when there's no wins for player" do
      before do
        allow(board).to receive(:row_win?).and_return(false)
        allow(board).to receive(:column_win?).and_return(false)
        allow(board).to receive(:diagonal_win?).and_return(false)
      end

      it 'returns false' do
        result = player.win?(board)
        expect(result).to eq(false)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
