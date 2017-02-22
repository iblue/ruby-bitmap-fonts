module BDF
  class Canvas
    def initialize(width, height)
      @width = width
      @height = height
      @array = Array.new(height){Array.new(width, 0)}
    end

    def set(x, y)
      unless x < @width && y < @height
        # TODO: Maybe resize to other size to improve speed.
        resize(x+1, y+1)
      end

      @array[y][x] = 1
    end

    def resize(width, height)
      @array.map! do |line|
        if width > line.size
          line + [0]*(width - line.size)
        else
          line
        end
      end

      @width = width

      if height > @array.size
        # This is a loop, because the multiplication op on arrays does not work
        # with non-scalars. You have been warned.
        (height - @array.size).times do
          @array += [[0]*@width]
        end
      end

      @height = height
    end

    def to_a
      @array.dup
    end
  end
end
