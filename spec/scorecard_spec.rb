require 'scoreboard'

RSpec.describe Scoreboard do
  
  context "bowler bowls a gutter game, total score is 0" do
    it "adds frames with a score of 0" do
      scoreboard = Scoreboard.new
      frame = double :frame, accessFrame: [0,0], frameTotal: 0, checkForSpare: false, checkForStrike: false
      10.times{scoreboard.addFrame(frame)}
      expect(scoreboard.total).to eq(0)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "bowler bowls a scoring game, but no strikes or spares" do
    it "adds all frames with a score of 1, 0" do
      scoreboard = Scoreboard.new
      frame = double :frame, accessFrame: [1,0], frameTotal: 1, checkForSpare: false, checkForStrike: false
      10.times{scoreboard.addFrame(frame)}
      expect(scoreboard.total).to eq(10)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 1, 1" do
      scoreboard = Scoreboard.new
      frame = double :frame, accessFrame: [1,1], frameTotal: 2, checkForSpare: false, checkForStrike: false
      10.times{scoreboard.addFrame(frame)}
      expect(scoreboard.total).to eq(20)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds all frames with a score of 5, 4" do
      scoreboard = Scoreboard.new
      frame = double :frame, accessFrame: [5,4], frameTotal: 9, checkForSpare: false, checkForStrike: false
      10.times{scoreboard.addFrame(frame)}
      expect(scoreboard.total).to eq(90)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds frames with varying scores" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [1,8], frameTotal: 9, checkForSpare: false, checkForStrike: false
      frame2 = double :frame, accessFrame: [4,4], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [3,2], frameTotal: 5, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame3)
      expect(scoreboard.total).to eq(71)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "a bonus is added if a spare is bowled" do
    it "gives a bonus after the first frame is a spare and the second frame is bowled" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [2,8], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame2 = double :frame, accessFrame: [3,3], frameTotal: 6, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      expect(scoreboard.total).to eq(19)
      expect(scoreboard.frameCount).to eq(2)
    end

    it "gives several bonus' if multiple spares bowled" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [2,8], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame2 = double :frame, accessFrame: [3,3], frameTotal: 6, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [1,7], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame4 = double :frame, accessFrame: [4,4], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame5 = double :frame, accessFrame: [5,5], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame6 = double :frame, accessFrame: [6,2], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame8 = double :frame, accessFrame: [9,1], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame9 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame10 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.total).to eq(98)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "a bonus is added if a strike is bowled" do
    it "gives a bonus after the first frame is a strike and the second frame is bowled" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame2 = double :frame, accessFrame: [3,3], frameTotal: 6, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      expect(scoreboard.total).to eq(22)
      expect(scoreboard.frameCount).to eq(2)
    end

    it "gives several bonus' if multiple strikes bowled" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame2 = double :frame, accessFrame: [3,3], frameTotal: 6, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [1,7], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame4 = double :frame, accessFrame: [4,4], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame5 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame6 = double :frame, accessFrame: [6,2], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame8 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame9 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      frame10 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.total).to eq(106)
      expect(scoreboard.frameCount).to eq(10)
    end
  end
  
  context "mix of strikes and spares bowled" do
    it "gives bonus' and correct final score" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [1,4], frameTotal: 5, checkForSpare: false, checkForStrike: false
      frame2 = double :frame, accessFrame: [4,5], frameTotal: 9, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame4 = double :frame, accessFrame: [5,5], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame5 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame6 = double :frame, accessFrame: [0,1], frameTotal: 1, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [7,3], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame8 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame9 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame10 = double :frame, accessFrame: [5,3], frameTotal: 8, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.total).to eq(123)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "final frame has three rolls" do
    it "adds a single roll bonus if spare" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [1,4], frameTotal: 5, checkForSpare: false, checkForStrike: false
      frame2 = double :frame, accessFrame: [4,5], frameTotal: 9, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame4 = double :frame, accessFrame: [5,5], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame5 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame6 = double :frame, accessFrame: [0,1], frameTotal: 1, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [7,3], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame8 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame9 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame10 = double :frame, accessFrame: [2,8,6], frameTotal: 16, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.total).to eq(133)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds a double roll bonus if strike" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [1,4], frameTotal: 5, checkForSpare: false, checkForStrike: false
      frame2 = double :frame, accessFrame: [4,5], frameTotal: 9, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame4 = double :frame, accessFrame: [5,5], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame5 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame6 = double :frame, accessFrame: [0,1], frameTotal: 1, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [7,3], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame8 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame9 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame10 = double :frame, accessFrame: [10,8,2], frameTotal: 20, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.total).to eq(145)
      expect(scoreboard.frameCount).to eq(10)
    end

    it "adds final frame score of 30 if all strikes" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [1,4], frameTotal: 5, checkForSpare: false, checkForStrike: false
      frame2 = double :frame, accessFrame: [4,5], frameTotal: 9, checkForSpare: false, checkForStrike: false
      frame3 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame4 = double :frame, accessFrame: [5,5], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame5 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame6 = double :frame, accessFrame: [0,1], frameTotal: 1, checkForSpare: false, checkForStrike: false
      frame7 = double :frame, accessFrame: [7,3], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame8 = double :frame, accessFrame: [6,4], frameTotal: 10, checkForSpare: true, checkForStrike: false
      frame9 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame10 = double :frame, accessFrame: [10,10,10], frameTotal: 30, checkForSpare: false, checkForStrike: false
      scoreboard.addFrame(frame1)
      scoreboard.addFrame(frame2)
      scoreboard.addFrame(frame3)
      scoreboard.addFrame(frame4)
      scoreboard.addFrame(frame5)
      scoreboard.addFrame(frame6)
      scoreboard.addFrame(frame7)
      scoreboard.addFrame(frame8)
      scoreboard.addFrame(frame9)
      scoreboard.addFrame(frame10)
      expect(scoreboard.calculateLastFrame).to eq(30)
      expect(scoreboard.total).to eq(157)
      expect(scoreboard.frameCount).to eq(10)
    end
  end

  context "perfect game is scored" do
    it "has a grand total of 300" do
      scoreboard = Scoreboard.new
      frame1 = double :frame, accessFrame: [10,0], frameTotal: 10, checkForSpare: false, checkForStrike: true
      frame10 = double :frame, accessFrame: [10,10,10], frameTotal: 30, checkForSpare: false, checkForStrike: false
      9.times{scoreboard.addFrame(frame1)}
      scoreboard.addFrame(frame10)
      expect(scoreboard.calculateLastFrame).to eq(30)
      expect(scoreboard.total).to eq(300)
      expect(scoreboard.frameCount).to eq(10)
    end
  end
end