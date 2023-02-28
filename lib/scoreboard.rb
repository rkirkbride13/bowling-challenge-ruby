class Scoreboard
  def initialize
    @scoreboard = []
    @frame_count = 0
  end

  def addFrame(frame)
    @frame_array = frame.accessFrame
    checkForFails
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
    last_frame = @scoreboard[9]
    @frame_count == 10 ? last_frame.frameTotal : 0
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
              if frame2
                @sum += (frame_index == 8 ? frame1.accessFrame[0..1].sum : frame1.accessFrame[0] + frame2.accessFrame[0])
              end
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

  private

  def checkForFails
    fail "A roll cannot be greater than 10" if (@frame_array[0] || @frame_array[1]) > 10
    if @frame_count < 9
      fail "Sum of rolls cannot be greater than 10" if @frame_array.sum > 10
    else
      if @frame_array[0..1].count(10) == 0
      fail "Sum of rolls cannot be greater than 10" if @frame_array[0..1].sum > 10
      elsif @frame_array[1..2].count(10) == 0
        fail "Sum of rolls cannot be greater than 10" if @frame_array[1..2].sum > 10
      end
    end
  end

  # def frameWithBonus
  #   accessScoreboard.each_with_index do |frame, index|
  #     if frame.checkForSpare && !accessScoreboard[index + 1]
  #       frame.frameTotal
  #     elsif frame.checkForSpare && accessScoreboard[index + 1]
  #       frame.frameTotal + accessScoreboard[index + 1].accessFrame[0]
  #     else
  #       frame.frameTotal
  #     end
  #   end
  # end

end