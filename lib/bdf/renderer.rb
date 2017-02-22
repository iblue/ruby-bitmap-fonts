module BDF
  class Renderer
    def self.render(text, opts = {})
      font = opts[:font]

      # Get baseline for initial cursor
      cursor = [0, font.bounding_box_y + font.displacement_y]

      text.chars.each do |char|
        # Lookup glyph
        glyph = font.glyph(char)

        cursor = glyph.render(canvas, cursor)
      end
    end
  end
end
