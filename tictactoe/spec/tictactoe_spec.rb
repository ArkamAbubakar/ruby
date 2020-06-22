require "./lib/tictactoe"

describe Board do
  describe "#check_win" do
    it "correctly determines winner" do
      b = Board.new
      b.player_move_helper(1, 0, 0)
      b.player_move_helper(1, 0, 1)
      b.player_move_helper(1, 0, 2)
      expect(b.check_win).to eql("Player 1")
    end
  end

  describe "#player_move" do
    it "adds correct player's move when square is empty" do
      b = Board.new
      b.player_move_helper(1, 0, 0)
      expect(b.squares[0][0]).to eql("X")
    end

    it "doesn't change a square to a different symbol" do
      b = Board.new
      b.player_move_helper(1, 0, 0)
      b.player_move_helper(2, 0, 0)
      expect(b.squares[0][0]).to eql("X")
    end
  end
end