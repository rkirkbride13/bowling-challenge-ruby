require 'frame'
require 'scoreboard'

RSpec.describe "integration of frame and scoreboard" do

  context "bowler bowls a gutter game, total score is 0" do
    it "adds frames with a score of 0" do
      scoreboard = Scoreboard.new
      10.times{scoreboard.addFrame(Frame.new(0, 0))}
      expect(scoreboard.total).to eq(0)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "bowler bowls a scoring game, but no strikes or spares" do
    it "adds all frames with a score of 1, 0" do
      scoreboard = Scoreboard.new
      10.times{scoreboard.addFrame(Frame.new(1, 0))}
      expect(scoreboard.total).to eq(10)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 1, 1" do
      scoreboard = Scoreboard.new
      10.times{scoreboard.addFrame(Frame.new(1, 1))}
      expect(scoreboard.total).to eq(20)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 5, 4" do
      scoreboard = Scoreboard.new
      10.times{scoreboard.addFrame(Frame.new(5, 4))}
      expect(scoreboard.total).to eq(90)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds frames with varying scores" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 8))
      scoreboard.addFrame(Frame.new(2, 7))
      scoreboard.addFrame(Frame.new(3, 6))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(5, 4))
      scoreboard.addFrame(Frame.new(6, 3))
      scoreboard.addFrame(Frame.new(7, 2))
      scoreboard.addFrame(Frame.new(8, 1))
      scoreboard.addFrame(Frame.new(4, 4))
      scoreboard.addFrame(Frame.new(3, 5))
      expect(scoreboard.total).to eq(88)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "a bonus is added if a spare is bowled" do
    it "gives a bonus after the first frame is a spare and the second frame is bowled" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(2, 8))
      scoreboard.addFrame(Frame.new(3, 3))
      expect(scoreboard.total).to eq(19)
      expect(scoreboard.frameCount).to eq(2)
    end

    it "gives several bonus' if multiple spares bowled" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(2, 8))
      scoreboard.addFrame(Frame.new(3, 3))
      scoreboard.addFrame(Frame.new(1, 7))
      scoreboard.addFrame(Frame.new(4, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(6, 2))
      scoreboard.addFrame(Frame.new(5, 3))
      scoreboard.addFrame(Frame.new(9, 1))
      scoreboard.addFrame(Frame.new(5, 3))
      scoreboard.addFrame(Frame.new(5, 3))
      expect(scoreboard.total).to eq(98)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "a bonus is added if a strike is bowled" do
    it "gives a bonus after the first frame is a strike and the second frame is bowled" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(3, 3))
      expect(scoreboard.total).to eq(22)
      expect(scoreboard.frameCount).to eq(2)
    end

    it "gives several bonus' if multiple strikes bowled" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(3, 3))
      scoreboard.addFrame(Frame.new(1, 7))
      scoreboard.addFrame(Frame.new(4, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(6, 2))
      scoreboard.addFrame(Frame.new(5, 3))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(5, 3))
      scoreboard.addFrame(Frame.new(5, 3))
      expect(scoreboard.total).to eq(106)
      expect(scoreboard.frameCount).to eq(10)
    end
  end
  
  context "mix of strikes and spares bowled" do
    it "gives bonus' and correct final score" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(5, 3))
      expect(scoreboard.total).to eq(123)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "final frame has three rolls" do
    it "adds a single roll bonus if spare" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(2, 8, 6))
      expect(scoreboard.total).to eq(133)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds a double roll bonus if strike" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(10, 8, 2))
      expect(scoreboard.total).to eq(145)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds final frame score of 30 if all strikes" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(10, 10, 10))
      expect(scoreboard.calculateLastFrame).to eq(30)
      expect(scoreboard.total).to eq(157)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "perfect game is scored" do
    it "has a grand total of 300" do
      scoreboard = Scoreboard.new
      9.times{scoreboard.addFrame(Frame.new(10, 0))}
      scoreboard.addFrame(Frame.new(10, 10, 10))
      expect(scoreboard.calculateLastFrame).to eq(30)
      expect(scoreboard.total).to eq(300)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "fails" do
    it "fails if a roll is greater than 10" do
      scoreboard = Scoreboard.new
      expect{scoreboard.addFrame(Frame.new(11, 0))}.to raise_error("A roll cannot be greater than 10")
    end

    it "fails if both rolls sum greater than 10" do
      scoreboard = Scoreboard.new
      expect{scoreboard.addFrame(Frame.new(5, 6))}.to raise_error("Sum of rolls cannot be greater than 10")
    end

    it "fails if the final frame is a strike first roll then two scores that add to more than 10" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      expect{scoreboard.addFrame(Frame.new(10, 8, 3))}.to raise_error("Sum of rolls cannot be greater than 10")
    end

    it "fails if the final frame is two scores that add to more than 10" do
      scoreboard = Scoreboard.new
      scoreboard.addFrame(Frame.new(1, 4))
      scoreboard.addFrame(Frame.new(4, 5))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(5, 5))
      scoreboard.addFrame(Frame.new(10, 0))
      scoreboard.addFrame(Frame.new(0, 1))
      scoreboard.addFrame(Frame.new(7, 3))
      scoreboard.addFrame(Frame.new(6, 4))
      scoreboard.addFrame(Frame.new(10, 0))
      expect{scoreboard.addFrame(Frame.new(9, 2, 3))}.to raise_error("Sum of rolls cannot be greater than 10")
    end

  end
end