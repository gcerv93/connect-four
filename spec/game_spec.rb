# frozen_string_literal: true

require_relative '../lib/game'

# rubocop: disable Metrics/BlockLength

describe Game do
  describe '#initialize' do
    it 'instantiates new board object' do
      expect(Board).to receive(:new).exactly(1).times
      Game.new
    end
  end

  subject(:game) { described_class.new }

  describe '#assign_players' do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return('playerone', 'playertwo')
    end

    it 'sends 2 messages to player' do
      expect(Player).to receive(:new).exactly(2).times
      game.assign_players
    end

    it 'assigns player one' do
      expect { game.assign_players }.to change { game.player_one }.to(Player)
    end

    it 'assigns player two' do
      expect { game.assign_players }.to change { game.player_two }.to(Player)
    end

    before do
      allow(Player).to receive(:new).and_return(Player)
    end

    it 'sets the current player' do
      expect { game.assign_players }.to change { game.current_player }.to(Player)
    end
  end

  describe '#change_current_player' do
    context 'when the current player is player one' do
      before do
        game.instance_variable_set(:@player_one, instance_double(Player))
        game.instance_variable_set(:@player_two, instance_double(Player))
      end

      it 'changes to player two' do
        game.instance_variable_set(:@current_player, game.player_one)
        expect { game.send(:change_current_player) }.to change { game.current_player }.to(game.player_two)
      end
    end

    context 'when the current player is player two' do
      before do
        game.instance_variable_set(:@player_one, instance_double(Player))
        game.instance_variable_set(:@player_two, instance_double(Player))
      end

      it 'changes to player one' do
        game.instance_variable_set(:@current_player, game.player_two)
        expect { game.send(:change_current_player) }.to change { game.current_player }.to(game.player_one)
      end
    end
  end
end

# rubocop: enable Metrics/BlockLength
