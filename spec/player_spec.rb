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
end

# rubocop: enable Metrics/BlockLength
