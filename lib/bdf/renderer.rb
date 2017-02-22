module BDF
  class Renderer
    def self.render(text, opts = {})
      font = opts[:font]

      # Get baseline for initial cursor
      cursor = [0, -font.displacement_y]

      # Initial size of one char. resizes automatically
      canvas = Canvas.new(font.bounding_box_x, font.bounding_box_y)

      text.chars.each do |char|
        # Lookup glyph
        glyph = font.glyph(char)

        cursor = glyph.render(canvas, cursor)
      end

      canvas
    end
  end
end
