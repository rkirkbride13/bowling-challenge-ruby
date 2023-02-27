class Frame

  def initialize
    @frame = []
    # @frame << roll_1
    # @frame << roll_2
    # if roll_3 != 0 then @frame << roll_3 end
  end

  def addRoll(roll)
    @frame << roll
  end

  def accessFrame
    return @frame
  end

  def frameTotal
    @frame.sum
  end

  def checkForSpare
    @frame[0] < 10 && @frame.sum == 10 ? true : false
  end

  def checkForStrike
    @frame[0] == 10 ? true : false
  end

end