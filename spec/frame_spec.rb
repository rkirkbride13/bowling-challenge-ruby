require 'frame'

RSpec.describe Frame do

  it "adds gutter rolls to frame and totals 0" do
    frame_1 = Frame.new(0, 0)
    expect(frame_1.accessFrame).to eq([0,0])
    expect(frame_1.frameTotal).to eq(0)
  end

  it "adds score rolls to frame and totals less than 10" do
    frame_1 = Frame.new(2, 7)
    expect(frame_1.accessFrame).to eq([2,7])
    expect(frame_1.frameTotal).to eq(9)
  end

  it "adds score rolls to frame and that give a spare" do
    frame_1 = Frame.new(2, 8)
    expect(frame_1.accessFrame).to eq([2,8])
    expect(frame_1.frameTotal).to eq(10)
    expect(frame_1.checkForSpare).to eq(true)
  end

  it "is a strike and checks for strike" do
    frame_1 = Frame.new(10, 0)
    expect(frame_1.accessFrame).to eq([10, 0])
    expect(frame_1.frameTotal).to eq(10)
    expect(frame_1.checkForStrike).to eq(true)
  end

end