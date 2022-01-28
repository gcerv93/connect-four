# frozen_string_literal: true

require_relative '../lib/game'

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

    it 'assigns playerone' do
      expect { game.assign_players }.to change { game.player_one }.to(Player)
    end

    it 'assigns player two' do
      expect { game.assign_players }.to change { game.player_two }.to(Player)
    end
  end
end
