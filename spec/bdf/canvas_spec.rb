require "spec_helper"

RSpec.describe BDF::Canvas do
  it "automatically resizes" do
    canvas = BDF::Canvas.new(2, 3)

    expect(canvas.to_a).to eq([
      [0, 0],
      [0, 0],
      [0, 0]
    ])

    canvas.set(5, 7)

    expect(canvas.to_a).to eq([
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1]
    ])

    canvas.set(2, 5)
    canvas.set(0, 0)
    expect(canvas.to_a).to eq([
      [1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 1]
    ])
  end
end
