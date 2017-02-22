require "spec_helper"

RSpec.describe BDF::Font do
  context "parsing a file" do
    let(:font) { BDF::Font.from_file("fixtures/ter-u20b.bdf") }

    it "parses STARTFONT to version" do
      expect(font.version).to eq("2.1")
    end

    it "parses FONT to name" do
      expect(font.name).to eq("-xos4-Terminus-Bold-R-Normal--20-200-72-72-C-100-ISO10646-1")
    end

    it "parses SIZE" do
      expect(font.size).to eq(20)
      expect(font.x_resolution).to eq(72)
      expect(font.y_resolution).to eq(72)
    end

    it "parses FONTBOUNDINGBOX" do
      expect(font.bounding_box_x).to eq(10)
      expect(font.bounding_box_y).to eq(20)
      expect(font.displacement_x).to eq(0)
      expect(font.displacement_y).to eq(-4)
    end

    it "parses PROPERTIES" do
      expect(font.properties["FAMILY_NAME"]).to eq("Terminus")
      expect(font.properties["FOUNDRY"]).to eq("xos4")
      expect(font.properties["SETWIDTH_NAME"]).to eq("Normal")
      expect(font.properties["ADD_STYLE_NAME"]).to eq("")
      expect(font.properties["COPYRIGHT"]).to eq("Copyright (C) 2015 Dimitar Toshkov Zhekov - Modified for testing purposes by Markus Fenske")
      expect(font.properties["NOTICE"]).to eq("Licensed under the SIL Open Font License, Version 1.1")
      expect(font.properties["WEIGHT_NAME"]).to eq("Bold")
      expect(font.properties["SLANT"]).to eq("R")
      expect(font.properties["PIXEL_SIZE"]).to eq(20)
      expect(font.properties["POINT_SIZE"]).to eq(200)
      expect(font.properties["RESOLUTION_X"]).to eq(72)
      expect(font.properties["RESOLUTION_Y"]).to eq(72)
      expect(font.properties["SPACING"]).to eq("C")
      expect(font.properties["AVERAGE_WIDTH"]).to eq(100)
      expect(font.properties["CHARSET_REGISTRY"]).to eq("ISO10646")
      expect(font.properties["CHARSET_ENCODING"]).to eq("1")
      expect(font.properties["MIN_SPACE"]).to eq(10)
      expect(font.properties["FONT_ASCENT"]).to eq(16)
      expect(font.properties["FONT_DESCENT"]).to eq(4)
      expect(font.properties["DEFAULT_CHAR"]).to eq(65533)
    end

    context "parses CHAR exclam" do
      let(:char) { font.char("exclam") }

      # FIX that later
      it "returns a Char" do
      end
    end
  end
end
