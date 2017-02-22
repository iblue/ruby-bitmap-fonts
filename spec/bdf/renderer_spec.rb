require "spec_helper"

RSpec.describe BDF::Font do
  context "render a string" do
    let(:font) { BDF::Font.from_file("fixtures/ter-u12b.bdf") }

    it "renders" do
      canvas = BDF::Renderer.render("just a test", :font => font)

      result = canvas.to_a.map do |line|
        line.map { |x| x == 1 ? "#" : " " }.join
      end

      byebug

      expect(result).to eq([
        "                                                                 ",
        "    #                                                            ",
        "    #               #                       #                 #  ",
        "                    #                       #                 #  ",
        "   ## #   #  ####  ###         ###         ###   ###   ####  ### ",
        "    # #   # #       #             #         #   #   # #       #  ",
        "    # #   #  ###    #          ####         #   #####  ###    #  ",
        "    # #   #     #   #         #   #         #   #         #   #  ",
        "    # #   #     #   #         #   #         #   #         #   #  ",
        "    #  #### ####     ##        ####          ##  #### ####     ##",
        " #  #                                                            ",
        "  ##                                                             ",
      ])
    end
  end
end
