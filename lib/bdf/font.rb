module BDF
  class Font
    class ParseError < Exception; end

    def self.from_file(filename)
      self.new(filename)
    end

    def initialize(filename)
      @file = File.open(filename)
      parse
    end

    def char(name)
      Char.new(@chars[name])
    end

    attr_reader :version, :name, :size, :x_resolution, :y_resolution,
      :bounding_box_x, :bounding_box_y, :displacement_x, :displacement_y,
      :properties

    private
    # Specification:
    # https://www.adobe.com/content/dam/Adobe/en/devnet/font/pdfs/5005.BDF_Spec.pdf
    def parse
      @state = :start

      @file.each_line.each_with_index do |line, line_no|
        case @state
        when :start
          case line
          when /^STARTFONT (.*)$/
            @version = $1
            @state = :body
          else
            raise ParseError, "Expected 'STARTFONT' command"
          end
        when :body
          case line
          when /^COMMENT /
            # Ignore
          when /^FONT (.*)$/
            @name = $1
          when /^SIZE (\d+) (\d+) (\d+)$/
            @size = $1.to_i
            @x_resolution = $2.to_i
            @y_resolution = $3.to_i
          when /^FONTBOUNDINGBOX (-?\d+) (-?\d+) (-?\d+) (-?\d+)$/
            @bounding_box_x = $1.to_i
            @bounding_box_y = $2.to_i
            @displacement_x = $3.to_i
            @displacement_y = $4.to_i
          when /^STARTPROPERTIES (\d+)$/
            @state = :properties
            @properties_count = $1.to_i
          when /^CHARS (\d+)$/
            @chars_count = $1.to_i
          when /^STARTCHAR (.+)$/
            @current_glyph_name = $1
            @state = :char
          when /^ENDFONT$/
            if @chars.size != @chars_count
              raise ParseError, "Expected #{@chars_count} chars, but got #{@chars.size}"
            end
            @state = :end
          else
            raise ParseError, "Unknown error in line #{line_no+1}: #{line}"
          end
        when :properties
          case line
          when /^ENDPROPERTIES$/
            @state = :body
            # They lied :(
            if @properties.size != @properties_count
              raise ParseError, "Expected #{@properties_count} properties, but got #{@properties.size}"
            end
          else
            @properties ||= {}
            key, value = line.split(" ", 2)
            @properties[key] = parse_value(value)
          end
        when :char
          @chars ||= {}
          @chars[@current_glyph_name] ||= {}

          case line
          when /^ENCODING (\d+)$/
            @chars[@current_glyph_name][:encoding] = $1.to_i
          when /^SWIDTH (\d+) (\d+)$/
            @chars[@current_glyph_name][:swidth] = {:x => $1.to_i, :y => $2.to_i}
          when /^DWIDTH (\d+) (\d+)$/
            @chars[@current_glyph_name][:dwidth] = {:x => $1.to_i, :y => $2.to_i}
          when /^BBX (-?\d+) (-?\d+) (-?\d+) (-?\d+)$/
            @chars[@current_glyph_name][:bbx] = {:w => $1.to_i, :h => $2.to_i, :off_x => $3.to_i, :off_y => $4.to_i}
          when /^BITMAP$/
            @state = :bitmap
          else
            raise ParseError, "Unknown error in line #{line_no+1}: #{line}"
          end
        when :bitmap
          case line
          when /^([A-F0-9]+)$/
            @chars[@current_glyph_name][:bitmap] ||= []
            @chars[@current_glyph_name][:bitmap] << $1
          when /^ENDCHAR$/
            @chars[@current_glyph_name][:bitmap] = parse_bitmap(@chars[@current_glyph_name][:bitmap])
            @state = :body
          else
            raise ParseError, "Expected bitmap or ENDCHAR line #{line_no+1}: #{line}"
          end
        end
      end

      if @state != :end
        raise ParseError, "Premature EOF"
      end
    end

    def parse_bitmap(bitmap)
      # FIXME
      bitmap
    end

    def parse_value(value)
      # That's not correct parsing, but it will work for most things.
      if value[0] == "\""
        value[1...-2].gsub('""','"')
      else
        value.to_i
      end
    end
  end
end
