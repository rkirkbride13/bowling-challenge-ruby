require 'frame'
require 'scoreboard'

RSpec.describe "integration of frame and scoreboard" do

  context "bowler bowls a gutter game, total score is 0" do
    it "adds frames with a score of 0" do
      scoreboard = Scoreboard.new
      10.times{
        frame = Frame.new
        frame.addRoll(0)
        frame.addRoll(0)
        scoreboard.addFrame(frame)
      }
      expect(scoreboard.total).to eq(0)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "bowler bowls a scoring game, but no strikes or spares" do
    it "adds all frames with a score of 1, 0" do
      scoreboard = Scoreboard.new
      10.times{
        frame = Frame.new
        frame.addRoll(1)
        frame.addRoll(0)
        scoreboard.addFrame(frame)
      }
      expect(scoreboard.total).to eq(10)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 1, 1" do
      scoreboard = Scoreboard.new
      10.times{
        frame = Frame.new
        frame.addRoll(1)
        frame.addRoll(1)
        scoreboard.addFrame(frame)
      }
      expect(scoreboard.total).to eq(20)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 5, 4" do
      scoreboard = Scoreboard.new
      10.times{
        frame = Frame.new
        frame.addRoll(5)
        frame.addRoll(4)
        scoreboard.addFrame(frame)
      }
      expect(scoreboard.total).to eq(90)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "a bonus is added if a spare is bowled" do
    it "gives a bonus after the first frame is a spare and the second frame is bowled" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(2)
      frame.addRoll(8)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(3)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      expect(scoreboard.total).to eq(19)
      expect(scoreboard.frameCount).to eq(2)
    end
  end

  context "a bonus is added if a strike is bowled" do
    it "gives a bonus after the first frame is a strike and the second frame is bowled" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(3)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      expect(scoreboard.total).to eq(22)
      expect(scoreboard.frameCount).to eq(2)
    end
  end
  
  context "mix of strikes and spares bowled" do
    it "gives bonus' and correct final score" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(1)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(4)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(5)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(0)
      frame.addRoll(1)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(7)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(5)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      expect(scoreboard.total).to eq(123)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "final frame has three rolls" do
    it "adds a single roll bonus if spare" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(1)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(4)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(5)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(0)
      frame.addRoll(1)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(7)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(2)
      frame.addRoll(8)
      frame.addRoll(6)
      scoreboard.addFrame(frame)
      expect(scoreboard.total).to eq(133)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds a double roll bonus if strike" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(1)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(4)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(5)
      frame.addRoll(5)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(0)
      frame.addRoll(1)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(7)
      frame.addRoll(3)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(6)
      frame.addRoll(4)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(0)
      scoreboard.addFrame(frame)
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(8)
      frame.addRoll(2)
      scoreboard.addFrame(frame)
      expect(scoreboard.total).to eq(145)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "perfect game is scored" do
    it "has a grand total of 300" do
      scoreboard = Scoreboard.new
      9.times{
        frame = Frame.new
        frame.addRoll(10)
        frame.addRoll(0)
        scoreboard.addFrame(frame)}
        frame = Frame.new
        frame.addRoll(10)
        frame.addRoll(10)
        frame.addRoll(10)
      scoreboard.addFrame(frame)
      expect(scoreboard.calculateLastFrame).to eq(30)
      expect(scoreboard.total).to eq(300)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "fails" do
    it "fails if a roll is greater than 10" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(11)
      frame.addRoll(0)
      expect{scoreboard.addFrame(frame)}.to raise_error("A roll cannot be greater than 10")
    end

    it "fails if both rolls sum greater than 10" do
      scoreboard = Scoreboard.new
      frame = Frame.new
      frame.addRoll(5)
      frame.addRoll(6)
      expect{scoreboard.addFrame(frame)}.to raise_error("Sum of rolls cannot be greater than 10")
    end

    it "fails if the final frame is a strike first roll then two scores that add to more than 10" do
      scoreboard = Scoreboard.new
      9.times{
        frame = Frame.new
        frame.addRoll(5)
        frame.addRoll(4)
        scoreboard.addFrame(frame)
      }
      frame = Frame.new
      frame.addRoll(10)
      frame.addRoll(8)
      frame.addRoll(3)
      expect{scoreboard.addFrame(frame)}.to raise_error("Sum of rolls cannot be greater than 10")
    end

    it "fails if the final frame is two scores that add to more than 10" do
      scoreboard = Scoreboard.new
      9.times{
        frame = Frame.new
        frame.addRoll(5)
        frame.addRoll(4)
        scoreboard.addFrame(frame)
      }
      frame = Frame.new
      frame.addRoll(9)
      frame.addRoll(2)
      frame.addRoll(3)
      expect{scoreboard.addFrame(frame)}.to raise_error("Sum of rolls cannot be greater than 10")
    end

  end
end