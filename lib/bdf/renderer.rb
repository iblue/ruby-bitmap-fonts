module BDF
  class Renderer
    def self.render(text, opts = {})
      font = opts[:font]

      # Get baseline for initial cursor
      cursor = [0, -font.displacement_y]

      # Initial size of one char. resizes automatically
      canvas = Canvas.new(font.bounding_box_x, font.bounding_box_y)

      text.chars.each do |char|
        if char == "\n"
          cursor[0] = 0
          cursor[1] += font.bounding_box_y
          next
        end

        # Lookup glyph
        glyph = font.glyph(char)

        cursor = glyph.render(canvas, cursor)
      end

      canvas
    end
  end
end
