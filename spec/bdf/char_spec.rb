require "spec_helper"

RSpec.describe BDF::Char do
  let(:char) { BDF::Font.from_file("fixtures/ter-u20b.bdf").char("exclam") }

  it "hm..." do
    char
  end
end
