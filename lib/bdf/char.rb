module BDF
  class Char
    def initialize(opts = {})
      @encoding = opts[:encoding]
      @swidth   = opts[:swidth]
      @dwidth   = opts[:dwidth]
      @bbx      = opts[:bbx]
      @bitmap   = parse(opts[:bitmap])
      byebug
    end

    def render(canvas, cursor)
      bitmap.each_with_index do |line, y|
        line.each do |val, x|
          if val == 1
            canvas.set(x+cursor[0]+@bbx[:x], y+cursor[1]+@bbx[:y])
          end
        end
      end

      [cursor[0]+@dwidth[:x], cursor[1]+@dwidth[:y]]
    end

    private
    def parse(bitmap)
      lookup = {
        "0" => [0, 0, 0, 0],
        "1" => [0, 0, 0, 1],
        "2" => [0, 0, 1, 0],
        "3" => [0, 0, 1, 1],
        "4" => [0, 1, 0, 0],
        "5" => [0, 1, 0, 1],
        "6" => [0, 1, 1, 0],
        "7" => [0, 1, 1, 1],
        "8" => [1, 0, 0, 0],
        "9" => [1, 0, 0, 1],
        "A" => [1, 0, 1, 0],
        "B" => [1, 0, 1, 1],
        "C" => [1, 1, 0, 0],
        "D" => [1, 1, 0, 1],
        "E" => [1, 1, 1, 0],
        "F" => [1, 1, 1, 1]
      }

      bitmap = bitmap.each.map do |line|
        line.chars.map do |char|
          lookup.fetch(char)
        end.flatten[0...@bbx[:w]] # Shorten to bounding box width
      end[0...@bbx[:h]] # Shorten to bounding box height
    end
  end
end
