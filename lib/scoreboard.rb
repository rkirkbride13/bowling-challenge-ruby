class Scoreboard
  def initialize
    @scoreboard = []
    @frame_count = 0
  end

  def addFrame(frame)
    @frame_array = frame.accessFrame
    # checkForFails
    @scoreboard << frame
    @frame_count += 1
  end

  def frameCount
    return @frame_count
  end

  def accessScoreboard
    return @scoreboard
  end

  def calculateLastFrame
    @frame_count == 10 ? @scoreboard[9].frameTotal : 0
  end

  def calculateFramesTotal
    @scoreboard[0..8].each_with_index do |frame0, frame_index|
      frame1 = @scoreboard[frame_index + 1]
      frame2 = @scoreboard[frame_index + 2]
      if frame0.checkForSpare
        @sum += frame0.frameTotal + (frame1 ? frame1.accessFrame[0] : 0)
      elsif frame0.checkForStrike
          @sum += frame0.frameTotal
          if frame1
            if frame1.checkForStrike
              if frame_index == 8 then @sum += frame1.accessFrame[0..1].sum end
              if frame2 then @sum += frame1.accessFrame[0] + frame2.accessFrame[0] end
            else
              @sum += (frame1 ? frame1.accessFrame[0..1].sum : 0)
            end
          end
      else
        @sum += frame0.frameTotal
      end
    end
    return @sum
  end

  def total
    @sum = 0
    @sum += calculateFramesTotal
    @sum += calculateLastFrame
    return @sum
  end

end