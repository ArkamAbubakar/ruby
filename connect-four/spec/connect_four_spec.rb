require "./lib/connect_four"

describe Connect4 do
  describe "#move" do
    it "puts a token in the bottom when it is empty" do
      c = Connect4.new
      c.move("B", 3)
      expect(c.board[5][3]).to eql("B")
    end

    it "puts a token in the lowest possible spot in a certain column" do
      c = Connect4.new
      c.move("R", 4)
      c.move("B", 4)
      expect(c.board[4][4]).to eql("B")
    end

    it "doesn't place anything if the column is out of bounds" do
      c = Connect4.new
      expect(c.move("R", 10)).to eql(false)
    end

    it "doesn't place anything if the column is full" do
      c = Connect4.new
      c.move("R", 3)
      c.move("B", 3)
      c.move("R", 3)
      c.move("B", 3)
      c.move("R", 3)
      c.move("B", 3)
      
      expect(c.move("R", 3)).to eql(false)
    end
  end

  describe "#game_over" do
    it "correctly ends game on 4 in a row horizontally" do 
      c = Connect4.new
      c.move("R", 3)
      c.move("R", 4)
      c.move("R", 6)
      c.move("R", 5)
      expect(c.game_over(5, 5)).to eql("R")
    end

    it "correctly ends game on 4 vertically" do
      c = Connect4.new
      c.move("R", 3)
      c.move("R", 3)
      c.move("R", 3)
      c.move("R", 3)
      expect(c.game_over(2, 3)).to eql("R")
    end

    it "correctly ends game with 4 on major diagonal" do  
      c = Connect4.new
      c.move("B", 3)
      c.move("B", 3)
      c.move("B", 3)
      c.move("R", 3)
      c.move("B", 4)
      c.move("B", 4)
      c.move("R", 4)
      c.move("B", 5)
      c.move("R", 5)
      c.move("R", 6)
      expect(c.game_over(5, 6)).to eql("R")
    end

    it "correctly ends game with 4 on minor diagonal" do
      c = Connect4.new
      c.move("R", 3)
      c.move("B", 4)
      c.move("R", 4)
      c.move("B", 5)
      c.move("B", 5)
      c.move("R", 5)
      c.move("B", 6)
      c.move("B", 6)
      c.move("B", 6)
      c.move("R", 6)
      expect(c.game_over(2, 6)).to eql("R")
    end
  end
end